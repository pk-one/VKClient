//
//  FriendsPhotoCollectionViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

private let reuseIdentifier = "FriendsPhotosCollectionViewCell"

class FriendsPhotosCollectionViewController: UICollectionViewController{
    
    var photos: [String]?
    let countCells = 2
    let offSet: CGFloat = 2
    var selectedCell: UICollectionViewCell!
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.photos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FriendsPhotosCollectionViewCell,
              let photosSelectedFriends = photos?[indexPath.item] else { return UICollectionViewCell() }
        cell.photosFriendImageView.image = UIImage(named: photosSelectedFriends)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let survayViewController = storyboard?.instantiateViewController(identifier: "SurvayViewController") as? SurveyFriendsPhotoViewController else { return }
        selectedCell = collectionView.cellForItem(at: indexPath)
        survayViewController.photos = photos
        survayViewController.index = indexPath.item
        survayViewController.modalPresentationStyle = .fullScreen
        survayViewController.selectedCell = selectedCell
        navigationController?.delegate = self
        navigationController?.pushViewController(survayViewController, animated: true)
    }
}

extension FriendsPhotosCollectionViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) ->
    UIViewControllerAnimatedTransitioning? {
        var animatedTransitioning: UIViewControllerAnimatedTransitioning? = nil
        switch operation {
        case .push:
            animatedTransitioning = FullPhotoAnimator(presentationStartCell: selectedCell, isPresenting: true)
        case .pop:
            animatedTransitioning = FullPhotoAnimator(presentationStartCell: selectedCell, isPresenting: false)
        default:
            break
        }
        return animatedTransitioning
    }
}


extension FriendsPhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameVC = collectionView.frame
        let widthCell = frameVC.width / 2
        let heightCell = widthCell
        let spacing = CGFloat((countCells + 1)) * offSet / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: heightCell - (offSet * 2))
    }
}
