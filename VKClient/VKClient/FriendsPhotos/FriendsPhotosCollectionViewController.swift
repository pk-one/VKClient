//
//  FriendsPhotoCollectionViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class FriendsPhotosCollectionViewController: UICollectionViewController{
    
    var ownerId: Int!
    private var photosList = [Photos]()
    private let countCells = 2
    private let offSet: CGFloat = 2
    private var selectedIndexPath: IndexPath?
    private let networkService: NetworkService = NetworkServiceImplementation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getPhotos(ownerId: ownerId, completionHandler: { [weak self] photos in
            self?.photosList = photos
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(FriendsPhotosCollectionViewCell.self, for: indexPath)
        let photosSelectedFriends = photosList[indexPath.item]
        cell.configure(with: photosSelectedFriends)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let survayViewController = storyboard?.instantiateViewController(identifier: "SurvayViewController") as? SurveyFriendsPhotoViewController else { return }
        selectedIndexPath = indexPath
        survayViewController.photos = photosList
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
