//
//  Endpoint.swift
//  VK friend list
//
//  Created by Vladimir on 21/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Alamofire

enum Endpoint: URLRequestConvertible {

    static let baseUrl = "https://api.vk.com/method"

    case friends

    var path: String {
        switch self {
        case .friends:
            return "friends.get"
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let baseUrl = try Endpoint.baseUrl.asURL()
        
        let url = baseUrl.appendingPathComponent(path)
        
        return URLRequest(url: url)
    }
}

//extension Endpoint: URLConvertible {
//
//    func asURL() throws -> URL {
//        return try asURLRequest().url!
//    }
//
//}
