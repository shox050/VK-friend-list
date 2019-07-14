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
    
    var totalUsersCount: Int = 0
    
    private var newUsers: [User] = []
    
    private var friendsCountInRequest = 50
    
    private let networkService: NetworkRequestable = NetworkService()
    
    private let executionQueue = DispatchQueue(label: "ListViewModelQueue", qos: .background, attributes: .concurrent)
    
    init(userAccessData: UserAccessData) {
        self.userAccessData = userAccessData
    }
    
    func getFriends(_ completion: @escaping () -> Void) {
        
        networkService.getFriends(forUser: userAccessData,
                                  withOffset: users.count,
                                  count: friendsCountInRequest) { [weak self] response in
            
            guard let this = self else { return }
                                    
            switch response {
            case .success(let userResponse):
                print("networkService.getFriends is success")
                
                this.users += userResponse.response.users
                this.newUsers = userResponse.response.users
                this.totalUsersCount = userResponse.response.count
                
                completion()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getLogo(_ completion: @escaping (Int) -> Void) {
        
        newUsers.forEach { user in
            networkService.getLogo(forUser: user) { [weak self] response in
                
                guard let this = self else { return }
                
                switch response {
                case .success(let data):
                    guard let logo = UIImage(data: data) else {
                        print("create image from data is failure")
                        return
                    }
                    
                    this.executionQueue.async(flags: .barrier, execute: {
                        
                        guard let index = this.users.firstIndex(where: { $0.id == user.id }) else { return }
                        
                        this.users[index].logo = logo
                        
                        DispatchQueue.global().async {
                            completion(index)
                        }
                    })
                    
                case .failure(let error):
                    print(RequestError.responseUnsuccessful, error.localizedDescription)
                }
            }
        }
    }
}
