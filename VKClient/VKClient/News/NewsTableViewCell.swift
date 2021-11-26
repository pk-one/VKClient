//
//  NewsTableViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 03.08.2021.
//

import UIKit

protocol NewsTableViewCellDelegate: AnyObject {
    func showMoreTappedButton(indexPath: IndexPath, postId: Int) -> Void
}

class NewsTableViewCell: UITableViewCell{
    
    weak var delegate: NewsTableViewCellDelegate?
    private var indexPath: IndexPath?
    private var postId: Int?
    private var isTappedShow = false

    
    private let newsImagesView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let newsTextLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var showMoreButton: UIButton = {
        var button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Показать больше", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 13)
        button.addTarget(self, action: #selector(showMoreTapped(_:)), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let insets: CGFloat = 10.0
    
    func configure(model: RealmNews, indexPath: IndexPath){
        self.indexPath = indexPath
        self.postId = model.postId
        switch indexPath.row {
        case 0:
            if !model.textNews.isEmpty {
                setupConstraints()
                self.newsTextLabel.text = model.textNews
                if model.textNews.count >= 200 {
                    setupConstraintsFromShowMoreButton()
                }
            } else {
                    addPhoto(with: model)
            }
        case 1:
                addPhoto(with: model)
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
    
    @objc private func showMoreTapped(_ sender: UIButton) {
        guard let indexPath = indexPath, let postId = postId else { return }
        isTappedShow.toggle()
        if isTappedShow {
            showMoreButton.setTitle("Показать меньше", for: .normal)
            self.newsTextLabel.numberOfLines = 0
        } else {
            showMoreButton.setTitle("Показать больше", for: .normal)
            self.newsTextLabel.numberOfLines = 3
        }
        delegate?.showMoreTappedButton(indexPath: indexPath, postId: postId)

    }
    
    private func setupConstraints() {
        self.contentView.addSubview(newsTextLabel)
        NSLayoutConstraint.activate([
            newsTextLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            newsTextLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            newsTextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
        ])
    }
    
    private func setupConstraintsFromShowMoreButton() {
        self.contentView.addSubview(showMoreButton)

        NSLayoutConstraint.activate([
        showMoreButton.topAnchor.constraint(equalTo: newsTextLabel.bottomAnchor, constant: 0),
        showMoreButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
        showMoreButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsImagesView.removeFromSuperview()
        self.newsTextLabel.text = nil
        NSLayoutConstraint.deactivate(newsImagesView.constraints)
    }
}
