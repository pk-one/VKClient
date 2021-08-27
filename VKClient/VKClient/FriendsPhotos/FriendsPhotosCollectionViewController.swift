//
//  FriendsPhotoCollectionViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class FriendsPhotosCollectionViewController: UICollectionViewController{
    
    var photos: [String]?
    private let countCells = 2
    private let offSet: CGFloat = 2
    private var selectedIndexPath: IndexPath?
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(FriendsPhotosCollectionViewCell.self, for: indexPath)
        guard let photosSelectedFriends = photos?[indexPath.item] else { return UICollectionViewCell() }
        cell.configure(with: photosSelectedFriends)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let survayViewController = storyboard?.instantiateViewController(identifier: "SurvayViewController") as? SurveyFriendsPhotoViewController else { return }
        selectedIndexPath = indexPath
        survayViewController.photos = photos
        survayViewController.index = indexPath.item
        survayViewController.modalPresentationStyle = .fullScreen
        //survayViewController.selectedIndexPath = selectedIndexPath
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
        guard let selectedIndexPath = selectedIndexPath, let selectedCell = collectionView.cellForItem(at: selectedIndexPath) else { return animatedTransitioning}
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
