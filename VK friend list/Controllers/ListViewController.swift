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
    
    private var listViewModel: ListViewModel!
    
    var userAccessData: UserAccessData!
    
    var users: [User] = []
        
    
    let identifier = Identifier()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getFriends(forUser: userAccessData, withOffset: 0) { [weak self] response in
            print("WORK")
            
            guard let self = self else { return }
            
            switch response {
            case .success(let userResponse):
                self.listViewModel = ListViewModel(userResponse)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listViewModel.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier.cell) as? FriendCell else {
            return FriendCell()
        }
        
//        let user = listViewModel.users[indexPath.row]
//
//        cell.configuration(with: user)
        
        return cell
    }
}

