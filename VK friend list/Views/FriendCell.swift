//
//  FriendCell.swift
//  VK friend list
//
//  Created by Vladimir on 22/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet private weak var ivLogo: UIImageView!
    
    @IBOutlet private weak var lName: UILabel!
    
    
    override func layoutSubviews() {
        ivLogo.layer.cornerRadius = ivLogo.frame.height / 2
    }
    
    func configuration(with user: User) {
        ivLogo.image = user.logo
        
        lName.text = ("\(user.name) \(user.lastName)")
    }
}
