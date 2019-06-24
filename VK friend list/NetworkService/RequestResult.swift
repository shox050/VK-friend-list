//
//  RequestResult.swift
//  VK friend list
//
//  Created by Vladimir on 23/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

enum RequestResult<S, F> where F: Error {
    case success(S)
    
    case failure(F)
}
