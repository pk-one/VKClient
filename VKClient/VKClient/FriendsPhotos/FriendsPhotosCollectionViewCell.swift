//
//  FriendsPhotosCollectionViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit
import Kingfisher

class FriendsPhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var photosFriendImageView: UIImageView!
    @IBOutlet private var customLikeControl: CustomLikeControl!
    
    func configure(with: Photos) {
        let url = URL(string: with.url)
        photosFriendImageView.kf.setImage(with: url)
        customLikeControl.countLikes = with.likes
    }
}
