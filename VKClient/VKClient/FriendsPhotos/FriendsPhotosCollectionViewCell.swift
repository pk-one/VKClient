//
//  FriendsPhotosCollectionViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class FriendsPhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var photosFriendImageView: UIImageView!
    
    func configure(with: String) {
        photosFriendImageView.image = UIImage(named: with)
    }
}

