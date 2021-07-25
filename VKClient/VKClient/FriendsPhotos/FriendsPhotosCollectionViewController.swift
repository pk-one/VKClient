//
//  FriendsPhotoCollectionViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

private let reuseIdentifier = "FriendsPhotosCollectionViewCell"

class FriendsPhotosCollectionViewController: UICollectionViewController {

    var userID: Int!
    let countCells = 2
    let offSet: CGFloat = 2
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return UserFriendsTableViewController.userFriends[self.userID!].photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendsPhotosCollectionViewCell
        
//        let avatar = UserFriendsTableViewController.userFriends[self.userID!].avatarImage
        let photos = UserFriendsTableViewController.userFriends[self.userID!].photos[indexPath.item]
        cell.photosFriendImage.image = UIImage(named: photos)
        return cell
    }

}



