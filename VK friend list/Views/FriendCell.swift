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
    
    @IBOutlet private weak var lLastName: UILabel!

//    override func layoutSubviews() {
//        ivLogo.layer.cornerRadius = frame.height / 2
//        ivLogo.layer.masksToBounds = false
//    }
    
    func configuration(with user: User) {
        ivLogo.image = user.logo
        
        lName.text = user.name
        
        lLastName.text = user.lastName
    }
}
