//
//  FriendsConverter.swift
//  VK friend list
//
//  Created by Vladimir on 26/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

class DictionaryEncoder {
    func encode<T>(entity: T) -> [String:Any]? where T: Encodable {
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(entity) else {
            print("Encode failure")
            return nil
        }
        
        print("Test")
        
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
    }
}
