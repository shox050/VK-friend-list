//
//  User.swift
//  VK friend list
//
//  Created by Vladimir on 23/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

struct UserResponse: Decodable {
    let response: UserWrapper
}

struct UserWrapper: Decodable {
    let count: Int
    
    let users: [User]
    
    
    enum CodingKeys: String, CodingKey {
        case count
        
        case users = "items"
    }
}

struct User: Decodable {
    let id: Int
    
    let name: String
    
    let lastName: String
    
    let logoPath: String
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        
        case name = "first_name"
        
        case lastName = "last_name"
        
        case logoPath = "photo_100"
    }
}
