//
//  Friend.swift
//  VK friend list
//
//  Created by Vladimir on 23/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

struct Friend: Decodable {
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
