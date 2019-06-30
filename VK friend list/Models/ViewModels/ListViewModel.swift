//
//  ListViewModel.swift
//  VK friend list
//
//  Created by Vladimir on 27/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ListViewModel {
    
    var userAccessData: UserAccessData!
    
    var users: [User] = []
    
    var newUsers: [User] = []
    
    var count: Int = 0
    
    private let networkService = NetworkService()
    
    
    func getFriends(_ complation: @escaping () -> Void) {
        networkService.getFriends(forUser: userAccessData, withOffset: 0) { [weak self] response in
            print("WORK networkService.getFriends")
            
            guard let self = self else { return }
            
            switch response {
            case .success(let userResponse):
                print("networkService.getFriends is success")
                
                self.users = userResponse.response.users
                self.count = userResponse.response.count
                
                complation()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getLogo(forUsers users: [User], _ completion: @escaping (Int) -> Void) {
        
        users.forEach { user in
            networkService.getLogo(forUser: user) { [weak self] response in
                
                guard let self = self else { return }
                
                switch response {
                case .success(let data):
                    guard let logo = UIImage(data: data) else {
                        print("create image from data is failure")
                        return
                    }
                    
                    if let index = self.users.firstIndex(where: { $0.id == user.id }) {
                        self.users[index].logo = logo
                        completion(index)
                    }
                    
                case .failure(let error):
                    print(RequestError.responseUnsuccessful, error.localizedDescription)
                }
            }
        }
    }
}
