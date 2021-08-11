//
//  NewsImagesCollectionView.swift
//  VKClient
//
//  Created by Pavel Olegovich on 05.08.2021.
//

import UIKit

class NewsImagesCollectionView: UICollectionView {
    var photos: [String]!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
            super.init(frame: frame, collectionViewLayout: layout)
        }
    
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


