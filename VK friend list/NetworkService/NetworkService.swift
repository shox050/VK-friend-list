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
                       _ completion: @escaping (DataResponse<Data>) -> Void) {
        
        let fields = "photo_100"
        
        let parameters: [String: Any] = ["user_id": accessData.userId,
                                         "order": "hints",
                                         "count": count,
                                         "offset": offset,
                                         "fields": fields]
        
        request(.friends, parameters: parameters, encoding: URLEncoding.default) { response in
            
        }
    }
}
