//
//  NewsTableFooterView.swift
//  VKClient
//
//  Created by Pavel Olegovich on 19.09.2021.
//

import UIKit
import Kingfisher

class NewsTableFooterView: UITableViewHeaderFooterView {

  
    private var likeImage: UIImageView = {
        let likeImage = UIImageView()
        likeImage.image = UIImage(named: "hearth-no-fill")
        likeImage.translatesAutoresizingMaskIntoConstraints = false
        return likeImage
    }()
    
    private var likeCountLabel: UILabel = {
        let likeLabel = UILabel()
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        return likeLabel
    }()
    
    private var commentsImage: UIImageView = {
        let commentsImage = UIImageView()
        commentsImage.image = UIImage(named: "comment")
        commentsImage.translatesAutoresizingMaskIntoConstraints = false
        return commentsImage
    }()

    private var commentsCountLabel: UILabel = {
        let commentsLabel = UILabel()
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        return commentsLabel
    }()
    
    private var repostImage: UIImageView = {
        let repostImage = UIImageView()
        repostImage.image = UIImage(named: "repost")
        repostImage.translatesAutoresizingMaskIntoConstraints = false
        return repostImage
    }()
    
    private var repostCountLabel: UILabel = {
        let repostLabel = UILabel()
        repostLabel.translatesAutoresizingMaskIntoConstraints = false
        return repostLabel
    }()
    
    private var viewsImage: UIImageView = {
        let viewsImage = UIImageView()
        viewsImage.image = UIImage(named: "eye")
        viewsImage.translatesAutoresizingMaskIntoConstraints = false
        return viewsImage
    }()
    
    private var viewsCountLabel: UILabel = {
         let viewsCountLabel = UILabel()
        viewsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        return viewsCountLabel
    }()
    
    private var footerView: UIView = {
        let footerView = UIView()
        footerView.backgroundColor = .systemBackground
        footerView.translatesAutoresizingMaskIntoConstraints = false
        return footerView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(footerView)
        footerView.addSubview(likeImage)
        footerView.addSubview(likeCountLabel)
        footerView.addSubview(commentsImage)
        footerView.addSubview(commentsCountLabel)
        footerView.addSubview(repostImage)
        footerView.addSubview(repostCountLabel)
        footerView.addSubview(viewsImage)
        footerView.addSubview(viewsCountLabel)
        NSLayoutConstraint.activate([

            footerView.topAnchor.constraint(equalTo: topAnchor),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.70),
            
            likeImage.widthAnchor.constraint(equalToConstant: 20),
            likeImage.heightAnchor.constraint(equalToConstant: 20),
            likeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            likeCountLabel.leadingAnchor.constraint(equalTo: likeImage.trailingAnchor, constant: 5),
            likeCountLabel.widthAnchor.constraint(equalToConstant: 40),

            commentsImage.widthAnchor.constraint(equalToConstant: 20),
            commentsImage.heightAnchor.constraint(equalToConstant: 20),
            commentsImage.leadingAnchor.constraint(equalTo: likeCountLabel.trailingAnchor, constant: 5),

            commentsCountLabel.widthAnchor.constraint(equalToConstant: 40),
            commentsCountLabel.leadingAnchor.constraint(equalTo: commentsImage.trailingAnchor, constant: 5),

            repostImage.widthAnchor.constraint(equalToConstant: 20),
            repostImage.heightAnchor.constraint(equalToConstant: 20),
            repostImage.leadingAnchor.constraint(equalTo: commentsCountLabel.trailingAnchor, constant: 5),
            
            repostCountLabel.widthAnchor.constraint(equalToConstant: 50),
            repostCountLabel.leadingAnchor.constraint(equalTo: repostImage.trailingAnchor, constant: 5),

            viewsImage.widthAnchor.constraint(equalToConstant: 20),
            viewsImage.heightAnchor.constraint(equalToConstant: 20),
            viewsImage.trailingAnchor.constraint(equalTo: viewsCountLabel.leadingAnchor, constant: -5),
            
            viewsCountLabel.widthAnchor.constraint(equalToConstant: 40),
            viewsCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(with: RealmNews) {
        likeCountLabel.text = String(with.likeCount)
        commentsCountLabel.text = String(with.commentCount)
        repostCountLabel.text = String(with.commentCount)
        viewsCountLabel.text = String(with.viewsCount)
    }
    
}
