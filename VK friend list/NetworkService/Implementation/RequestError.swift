//
//  RequestError.swift
//  VK friend list
//
//  Created by Vladimir on 23/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

enum RequestError: Error {
    
    case requestFailed
    
    case responseUnsuccessful
    
    case notConnected
    
    case jsonParsingFailure
    
    var localizedDescription: String {
        
        switch self {
        case .notConnected:
            return "Not connected to internet"
        case .requestFailed:
            return "Request failed"
        case .responseUnsuccessful:
            return "Response Unsuccessful"
        case .jsonParsingFailure:
            return "JSON parsing failure"
        }
    }
}
