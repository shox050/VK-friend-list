//
//  ListViewModel.swift
//  VK friend list
//
//  Created by Vladimir on 27/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

struct ListViewModel {
    var users: [User]
    
    var count: Int
    
    init(_ userResponse: UserResponse) {
        self.users = userResponse.response.users
        
        self.count = userResponse.response.count
    }
}
