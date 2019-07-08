//
//  NetworkRequestable.swift
//  VK friend list
//
//  Created by Vladimir on 08/07/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

protocol NetworkRequestable: class {
    func getFriends(forUser accessData: UserAccessData,
                    withOffset offset: Int,
                    count: Int,
                    _ completion: @escaping (Result<UserResponse, RequestError>) -> Void)
    
    func getLogo(forUser user: User,
                 _ completion: @escaping (Result<Data, RequestError>) -> Void)
}
