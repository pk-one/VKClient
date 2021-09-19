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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(model: News, indexPath: IndexPath){
        switch indexPath.row {
        case 0:
            if !model.textNews.isEmpty {
                setupUITextLabel()
                self.newsTextLabel.text = model.textNews
            } else {
                addPhoto(with: model, by: indexPath)
            }
        case 1:
            addPhoto(with: model, by: indexPath)
        default:
            break
        }
    }
    
    private func addPhoto(with: News, by indexPath: IndexPath) {
        self.addSubview(newsImagesView)
    
        NSLayoutConstraint.activate([
            newsImagesView.topAnchor.constraint(equalTo: topAnchor),
            newsImagesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImagesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImagesView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        let image = with.imageNews
        let url = URL(string: image)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsTextLabel.text = nil
        self.newsImagesView.image = nil
    }
}

