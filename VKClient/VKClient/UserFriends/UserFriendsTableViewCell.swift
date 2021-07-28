//
//  UserFriendsTableViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class UserFriendsTableViewCell: UITableViewCell {
    @IBOutlet var imageFriendImageView: UIImageView!
    @IBOutlet var fullNameFriendLabel: UILabel!
    
    override func awakeFromNib() {
        imageFriendImageView.layer.cornerRadius = 17
        imageFriendImageView.layer.masksToBounds = true
        imageFriendImageView.layer.borderWidth = 1
        imageFriendImageView.layer.borderColor = UIColor.white.cgColor
    }
}


