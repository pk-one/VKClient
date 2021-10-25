//
//  NewsImagesCollectionViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 04.08.2021.
//

import UIKit

class NewsImagesCollectionViewCell:
    
    UICollectionViewCell {
    static let reuseId = "NewsImagesCollectionViewCell"
    let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(newsImageView)
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: topAnchor),
            newsImageView.leftAnchor.constraint(equalTo: leftAnchor),
            newsImageView.rightAnchor.constraint(equalTo: rightAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(photo: String) {
        newsImageView.image = UIImage(named: photo)
    }
}
