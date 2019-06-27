//
//  NetworkService.swift
//  VK friend list
//
//  Created by Vladimir on 20/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    private let executionQueue = DispatchQueue(label: "NetwrokServiceQueue", qos: .background, attributes: .concurrent)
    
    private let configuration = NetworkServiceConfiguration()
    
    private let dictionaryEncoder = DictionaryEncoder()
    
    
    private func request(_ endpoint: Endpoint,
                         method: HTTPMethod = .get,
                         parameters: [String: Any]? = nil,
                         encoding: ParameterEncoding,
                         _ completion: @escaping (DataResponse<Data>) -> Void) {
        
        AF.request(endpoint,
                   method: method,
                   parameters: parameters,
                   encoding: encoding)
            .validate()
            .responseData(queue: executionQueue) { response in
                completion(response)
        }
    }
    
    func getFriends(forUser accessData: UserAccessData, withOffset offset: Int,
                       count: Int,
                       _ completion: @escaping (Result<UserResponse, RequestError>) -> Void) {
        
        let friends = Friends(userId: accessData.userId, token: accessData.token, count: count, offset: offset)
        
        var parameters = dictionaryEncoder.encode(entity: friends)
        
        parameters?["v"] = configuration.apiVersion
        
//        let fields = "photo_100"
        
//        let parameters: [String: Any] = ["user_id": accessData.userId,
//                                         "access_token": accessData.token,
//                                         "order": "hints",
//                                         "count": count,
//                                         "offset": offset,
//                                         "fields": fields,
//                                         "v": configuration.apiVersion]
        
        request(.friends, parameters: parameters, encoding: URLEncoding.default) { response in
            
            print("Response in getFriends: ", response.request)
            
            guard let responseData = response.data else {
                print(RequestError.responseUnsuccessful)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let userResponse = try jsonDecoder.decode(UserResponse.self, from: responseData)
                
                print("UserResponse parsing completed")
                
                completion(.success(userResponse))
            } catch let error {
                print("\(RequestError.jsonParsingFailure): \(error.localizedDescription)")
                
                completion(.failure(.jsonParsingFailure))
            }
        }
    }
}
