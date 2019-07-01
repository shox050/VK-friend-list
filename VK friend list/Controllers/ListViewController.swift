//
//  ListViewController.swift
//  VK friend list
//
//  Created by Vladimir on 20/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
        
    var listViewModel = ListViewModel()
    
    let identifier = Identifier()
    
        
    @IBOutlet private weak var tvFriendList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            guard let self = self else { return }
            
            self.listViewModel.getFriends { [weak self] in
                
                guard let self = self else { return }
                
                DispatchQueue.main.sync {
                    self.tvFriendList.reloadData()
                }
                
                self.listViewModel.newUsers = self.listViewModel.users
                
                self.listViewModel.getLogo { index in
                    
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
        
        return listViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier.cell) as? FriendCell else {
            return FriendCell()
        }
        
        cell.configuration(with: listViewModel.users[indexPath.row])
        
        return cell
    }
}

