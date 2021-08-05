//
//  NewsImagesCollectionView.swift
//  VKClient
//
//  Created by Pavel Olegovich on 05.08.2021.
//

import UIKit

class NewsImagesCollectionView: UICollectionView {
    var photos: [String]!
    let countCells = 2
    let offSet: CGFloat = 2
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.register(NewsImagesCollectionViewCell.self,
                      forCellWithReuseIdentifier: NewsImagesCollectionViewCell.reuseId)
        self.delegate = self
        self.dataSource = self
    }
    
    func set(photos: [String]) {
        self.photos = photos
        self.reloadData()
    }
}

extension NewsImagesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: NewsImagesCollectionViewCell.reuseId, for: indexPath) as? NewsImagesCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(photo: photos[indexPath.row])
        return cell
    }
}

extension NewsImagesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameVC = collectionView.frame
        let widthCell = frameVC.width / 2
        let heightCell = widthCell
        let spacing = CGFloat((countCells + 1)) * offSet / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: heightCell - (offSet * 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
