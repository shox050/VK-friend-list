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
    
    let configuration = NetworkServiceConfiguration()
    
    private func request(_ endpoint: Endpoint, method: HTTPMethod = .get, parameters: [String: Any]? = nil,
                         encoding: ParameterEncoding, _ completion: @escaping (DataResponse<Data>) -> Void) {
        
        AF.request(endpoint)
            .validate()
            .responseData(queue: executionQueue) { response in
                completion(response)
        }
    }
    
    func getFriends<T>(forUser accessData: UserAccessData, withOffset offset: Int,
                       count: Int, responseType: T.Type,
                       _ completion: @escaping (RequestResult<T, RequestError>) -> Void) where T: Decodable {
        
        
    }
}
