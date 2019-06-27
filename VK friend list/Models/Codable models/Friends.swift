//
//  Friends.swift
//  VK friend list
//
//  Created by Vladimir on 25/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

struct Friends: Encodable {
    let userId: String
    
    let token: String
    
    let order: String = "hints"
    
    let count: Int
    
    let offset: Int
    
    let fields: String = "photo_100"
    
    
    private enum CodingKeys: String, CodingKey {
        case userId
        
        case token
        
        case order
        
        case count
        
        case offset
        
        case fields
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(userId, forKey: .userId)
        
        try container.encode(token, forKey: .token)
        
        try container.encode(order, forKey: .order)

        try container.encode(count, forKey: .count)

        try container.encode(offset, forKey: .offset)

        try container.encode(fields, forKey: .fields)
    }
}
