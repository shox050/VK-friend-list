//
//  ListViewController.swift
//  VK friend list
//
//  Created by Vladimir on 20/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    private let networkService = NetworkService()
    
    var userAccessData: UserAccessData!
    
    
    let identifier = Identifier()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getFriends(forUser: userAccessData, withOffset: 0, count: 1) { users in
            print("WORK")
        }
    }
}


// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier.cell) as? FriendCell else {
            return FriendCell()
        }
                
        return cell
    }
}

