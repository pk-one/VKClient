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
    
    func configure(with: PhotosItems) {
        guard let size = with.sizes[3].url ?? with.sizes[2].url else { return }
        
        let url = URL(string: size)
        photosFriendImageView.kf.setImage(with: url)
        customLikeControl.countLikes = with.likes.count
    }
}
