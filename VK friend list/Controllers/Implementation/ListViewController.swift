//
//  ListViewController.swift
//  VK friend list
//
//  Created by Vladimir on 20/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, FriendListController {
        
    fileprivate var listViewModel: ListViewModel?
    
    let identifier = Identifier()
    
        
    @IBOutlet private weak var tvFriendList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFriends()

    }
    
    func configure(with configuration: FriendListConfiguration) {
        listViewModel = ListViewModel(userAccessData: configuration.userAccessData)
    }
    
    private func getFriends() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            guard let listViewModel = self.listViewModel else { return }
            
            listViewModel.getFriends {
                
                DispatchQueue.main.sync {
                    self.tvFriendList.reloadData()
                }
                
                listViewModel.getLogo { index in
                    
                    let indexPath = IndexPath(row: index, section: 0)
                    
                    DispatchQueue.main.sync {
                        self.tvFriendList.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        }
    }
}


// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listViewModel?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier.cell) as? FriendCell,
            let listViewModel = listViewModel else {
                return FriendCell()
        }
        
        if indexPath.row == listViewModel.users.count - 1 {
            if listViewModel.totalUsersCount > listViewModel.users.count {
                getFriends()
            }
        }

        cell.configuration(with: listViewModel.users[indexPath.row])
        
        return cell
    }
}

