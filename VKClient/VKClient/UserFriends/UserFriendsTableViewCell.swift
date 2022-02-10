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
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var userOnlineImageView: UIImageView!
    
    func configure(with friend: FriendsViewModel) {
        let url = URL(string: friend.avatarUrl)
        imageFriendImageView.kf.setImage(with: url)
        cityNameLabel.text = friend.city
        fullNameFriendLabel.text = friend.fullName
        
        if friend.online {
            userOnlineImageView.isHidden = false
        }
    }
}


