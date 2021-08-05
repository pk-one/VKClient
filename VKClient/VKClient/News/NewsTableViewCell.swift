//
//  NewsTableViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 03.08.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell{
    private let news = News.allPostCases
    
    ///MARK: Outlets
    @IBOutlet var headerNewsImageView: RoundedImageView!
    @IBOutlet var newsAuthorNameLabel: UILabel!
    @IBOutlet var timeNewsLabel: UILabel!
    @IBOutlet var textNewsLabel: UILabel!
    @IBOutlet var newsImagesCollectionView: NewsImagesCollectionView!
    @IBOutlet var countLikesLabel: UILabel!
    @IBOutlet private var likesImageView: UIImageView!
    @IBOutlet var countCommentsLabel: UILabel!
    @IBOutlet private var commentsImageView: UIImageView!
    @IBOutlet var countRepostsLabel: UILabel!
    @IBOutlet private var repostsImageView: UIImageView!
    @IBOutlet var countViewsLabel: UILabel!
    @IBOutlet private var viewsImageView: UIImageView!
    
    ///заполнение сердца
    public var isHeartFilled = false {
        didSet {
            likesImageView.image = isHeartFilled ? CellConsts.hearthFilled : CellConsts.hearthEmpty
        }
    }
    public var isCommentTap = false
    public var isRepostTap = false
    public var heartWasPressed = { }
    public var commentWasPressed = { }
    public var repostWasPressed = { }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        likesImageView.image = CellConsts.hearthEmpty
        commentsImageView.image = CellConsts.commentEmpty
        repostsImageView.image = CellConsts.repostEmpty
        let tapHeartGR = UITapGestureRecognizer(target: self, action: #selector(heartTap))
        likesImageView.addGestureRecognizer(tapHeartGR)
        let tapCommentGR = UITapGestureRecognizer(target: self, action: #selector(commentTap))
        commentsImageView.addGestureRecognizer(tapCommentGR)
        let tapRepostGR = UITapGestureRecognizer(target: self, action: #selector(repostTap))
        repostsImageView.addGestureRecognizer(tapRepostGR)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likesImageView.image = CellConsts.hearthEmpty
        commentsImageView.image = CellConsts.commentEmpty
        repostsImageView.image = CellConsts.repostEmpty
    }
    
    @objc func heartTap() {
        isHeartFilled.toggle()
        heartWasPressed()
        let countLikes = Int(countLikesLabel.text ?? "0") ?? 0
        if isHeartFilled {
            countLikesLabel.text = String(countLikes + 1)
        } else {
            countLikesLabel.text = String(countLikes - 1)
        }
    }
    
    @objc func commentTap() {
        isCommentTap.toggle()
        commentWasPressed()
        let countComments = Int(countCommentsLabel.text ?? "0") ?? 0
        if isCommentTap {
            countCommentsLabel.text = String(countComments + 1)
        } else {
            countCommentsLabel.text = String(countComments - 1)
        }
    }

    @objc func repostTap() {
        isRepostTap.toggle()
        repostWasPressed()
        let countReposts = Int(countRepostsLabel.text ?? "0") ?? 0
        if isRepostTap {
            countRepostsLabel.text = String(countReposts + 1)
        } else {
            countRepostsLabel.text = String(countReposts - 1)
        }
    }
    
    private struct CellConsts {
        static let hearthEmpty = UIImage(named: "hearth-no-fill")
        static let hearthFilled = UIImage(named: "hearth-fill")
        static let commentEmpty =  UIImage(named: "comment")
        static let repostEmpty = UIImage(named: "repost")
    }
}

