//
//  NewsTableViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 03.08.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell{
    
    private let newsImagesView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let newsTextLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Arial", size: 13)
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let showMoreButton: UIButton = {
        var button = UIButton()
        button.setTitle("Показать больше", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 13)
        return button
    }()
    
    private let insets: CGFloat = 10.0
    
    func configure(model: RealmNews, indexPath: IndexPath){
        switch indexPath.row {
        case 0:
            if !model.textNews.isEmpty {
//                let countVisibleLine = newsTextLabel.font.lineHeight * 4
                setupUITextLabel()
                self.newsTextLabel.text = model.textNews
            } else {
                if model.imageSizeWidth != 0 {
                    addPhoto(with: model)
                }
            }
        case 1:
            if model.imageSizeWidth != 0 {
                addPhoto(with: model)
            }
        default:
            break
        }
    }
    
    private func addPhoto(with: RealmNews) {
        self.addSubview(newsImagesView)
        
        if with.imageSizeWidth == 0 {
            return
        }
        
        let height = CGFloat(with.imageSizeHeight*Int(bounds.width)/with.imageSizeWidth)
        
        NSLayoutConstraint.activate([
            newsImagesView.topAnchor.constraint(equalTo: topAnchor),
            newsImagesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImagesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImagesView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            newsImagesView.heightAnchor.constraint(equalToConstant: height),
            newsImagesView.widthAnchor.constraint(equalToConstant: bounds.width)
        ])
        
        let url = URL(string: with.imageNews)
        newsImagesView.kf.setImage(with: url)
    }
    
    private func setupUITextLabel() {
        self.addSubview(newsTextLabel)
        NSLayoutConstraint.activate([
            newsTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            newsTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            newsTextLabel.topAnchor.constraint(equalTo: topAnchor),
            newsTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
    
    private func setupShowMoreButton() {
        
        self.addSubview(showMoreButton)
        NSLayoutConstraint.activate([
            showMoreButton.topAnchor.constraint(equalTo: newsTextLabel.bottomAnchor, constant: 5),
            showMoreButton.leadingAnchor.constraint(equalTo: newsTextLabel.leadingAnchor),
            showMoreButton.trailingAnchor.constraint(equalTo: newsTextLabel.trailingAnchor),
            showMoreButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsImagesView.image = nil
        
        NSLayoutConstraint.deactivate(newsImagesView.constraints)
    }
}
