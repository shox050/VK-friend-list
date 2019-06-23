//
//  AutorizationPathConfiguration.swift
//  VK friend list
//
//  Created by Vladimir on 21/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

struct AutorizationPathConfiguration {
    
    private let networkConfiguration = NetworkServiceConfiguration()
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [URLQueryItem(name: "client_id", value: String(networkConfiguration.applicationId)),
                                    URLQueryItem(name: "display", value: "mobile"),
                                    URLQueryItem(name: "redirect_url", value: "https://oauth.vk.com/blank.html"),
                                    URLQueryItem(name: "scope", value: "friends"),
                                    URLQueryItem(name: "response_type", value: "token"),
                                    URLQueryItem(name: "v", value: "\(networkConfiguration.apiVersion)")]
        
//        print("urlComponents.url: ", urlComponents.url)
        
        return urlComponents.url
    }
}


