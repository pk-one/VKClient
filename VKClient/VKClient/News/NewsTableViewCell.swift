//
//  NewsTableViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 03.08.2021.
//

import UIKit

protocol NewsTableViewCellDelegate: AnyObject {
    func heartWasPressed(in indexPath: IndexPath, and isSelected: Bool)
    func commentWasPressed(in indexPath: IndexPath, and isSelected: Bool)
    func repostWasPressed(in indexPath: IndexPath, and isSelected: Bool)
}

class NewsTableViewCell: UITableViewCell{
    
    private let news = News.allPostCases
    var indexPath: Int?
    var selectedIndexPath: IndexPath?
    //MARK:  - Outlets
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
    
    
    //MARK: - Footer Cell
    ///заполнение сердца
    public var isHeartFilled = false {
        didSet {
            likesImageView.image = isHeartFilled ? CellConsts.hearthFilled : CellConsts.hearthEmpty
        }
    }
    public var isCommentTap = false
    public var isRepostTap = false
    
    weak var delegate: NewsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        guard let selectedIndexPath = selectedIndexPath,
              let indexPath = indexPath else { return }
        setupAnimationHearth()
        isHeartFilled.toggle()
        delegate?.heartWasPressed(in: selectedIndexPath, and: isHeartFilled)
        let countLikes = news[indexPath].countLikeNews
        countLikesLabel.text = isHeartFilled ? formattedCounter(countLikes + 1) : formattedCounter(countLikes)
    }
    
    @objc func commentTap() {
        guard let selectedIndexPath = selectedIndexPath,
              let indexPath = indexPath else { return }
        isCommentTap.toggle()
        delegate?.commentWasPressed(in: selectedIndexPath, and: isCommentTap)
        let countComments = news[indexPath].countCommentsNews
        countCommentsLabel.text = isCommentTap ? formattedCounter(countComments + 1) : formattedCounter(countComments)
    }
    
    @objc func repostTap() {
        guard let selectedIndexPath = selectedIndexPath,
              let indexPath = indexPath else { return }
        isRepostTap.toggle()
        delegate?.repostWasPressed(in: selectedIndexPath, and: isRepostTap)
        let countReposts = news[indexPath].countRepostsNews
        countRepostsLabel.text = isRepostTap ? formattedCounter(countReposts + 1) : formattedCounter(countReposts)
    }
    
    func configureIndexPath(with indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    ///анимация лайка
    private func setupAnimationHearth() {
        let degree: Double = 180
        let rotationAngle = CGFloat(degree * Double.pi / 180)
        let rotaionTransform = CATransform3DMakeRotation(rotationAngle, 0, 1, 0)
        likesImageView.layer.transform = rotaionTransform
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.likesImageView.layer.transform = CATransform3DIdentity
        }
    }
    
    //MARK: - Setup Cell
    private struct CellConsts {
        static let hearthEmpty = UIImage(named: "hearth-no-fill")
        static let hearthFilled = UIImage(named: "hearth-fill")
        static let commentEmpty = UIImage(named: "comment")
        static let repostEmpty = UIImage(named: "repost")
    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter else { return nil }
        var counterString = String(counter)
        if 4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "M"
        }
        return counterString
    }
    
    func configure(with: News) {
            self.headerNewsImageView.image = UIImage(named: with.imageHeaderNews)
            self.newsAuthorNameLabel.text = with.nameAuthorNews
            self.timeNewsLabel.text = with.timeNews
            self.textNewsLabel.text = with.textNews
            self.countLikesLabel.text = formattedCounter(with.countLikeNews)
            self.countCommentsLabel.text = formattedCounter(with.countCommentsNews)
            self.countRepostsLabel.text = formattedCounter(with.countRepostsNews)
            self.countViewsLabel.text = formattedCounter(with.countViewsNews)
        }
}

