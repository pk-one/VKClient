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
    @IBOutlet private var cityFriendLabel: UILabel!
    
    func configure(with friends: Friends) {
        let url = URL(string: friends.avatar)
        imageFriendImageView.kf.setImage(with: url)
        fullNameFriendLabel.text = friends.fullName
        cityFriendLabel.text = friends.city
    }
}


