//
//  UserFriendsTableViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class UserFriendsTableViewCell: UITableViewCell {
    @IBOutlet private var imageFriendImageView: RoundedImageView!
    @IBOutlet private var fullNameFriendLabel: UILabel!
    
    func configure(with: User) {
        imageFriendImageView.image = UIImage(named: with.avatarImage)
        fullNameFriendLabel.text = with.fullName
    }
}


