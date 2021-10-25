//
//  NewsTableFooterView.swift
//  VKClient
//
//  Created by Pavel Olegovich on 19.09.2021.
//

import UIKit
import Kingfisher

protocol NewsTableFooterViewDelegate: AnyObject {
    func heartWasPressed(at objectId: Int)
    func commentWasPressed(with postID: Int, for ownerID: Int )
}

class NewsTableFooterView: UITableViewHeaderFooterView {

    var indexPath: Int?
    var selectedIndexPath: IndexPath?
    
    /// Идентификатор объекта
    private var newsPostID = 0
    private var newsOwnerID = 0
    
    weak var delegate: NewsTableFooterViewDelegate?
    
    private var likeImage: UIImageView = {
        let likeImage = UIImageView()
        likeImage.image = CellConsts.hearthEmpty
        likeImage.translatesAutoresizingMaskIntoConstraints = false
        likeImage.isUserInteractionEnabled = true
        return likeImage
    }()
    
    private var likeCountLabel: UILabel = {
        let likeLabel = UILabel()
        likeLabel.font = UIFont(name: "Arial", size: 18)
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        return likeLabel
    }()
    
    private var commentsImage: UIImageView = {
        let commentsImage = UIImageView()
        commentsImage.image = CellConsts.commentEmpty
        commentsImage.translatesAutoresizingMaskIntoConstraints = false
        commentsImage.isUserInteractionEnabled = true
        return commentsImage
    }()

    private var commentsCountLabel: UILabel = {
        let commentsLabel = UILabel()
        commentsLabel.font = UIFont(name: "Arial", size: 18)
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        return commentsLabel
    }()
    
    private var repostImage: UIImageView = {
        let repostImage = UIImageView()
        repostImage.image = CellConsts.repostEmpty
        repostImage.translatesAutoresizingMaskIntoConstraints = false
        return repostImage
    }()
    
    private var repostCountLabel: UILabel = {
        let repostLabel = UILabel()
        repostLabel.font = UIFont(name: "Arial", size: 18)
        repostLabel.translatesAutoresizingMaskIntoConstraints = false
        return repostLabel
    }()
    
    private var viewsImage: UIImageView = {
        let viewsImage = UIImageView()
        viewsImage.image = CellConsts.viewsEmpty
        viewsImage.translatesAutoresizingMaskIntoConstraints = false
        return viewsImage
    }()
    
    private var viewsCountLabel: UILabel = {
         let viewsCountLabel = UILabel()
        viewsCountLabel.font = UIFont(name: "Arial", size: 14)
        viewsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        return viewsCountLabel
    }()
    
    private var footerView: UIView = {
        let footerView = UIView()
        footerView.backgroundColor = .systemBackground
        footerView.translatesAutoresizingMaskIntoConstraints = false
        return footerView
    }()
    
    public var isHeartFilled = false {
        didSet {
            likeImage.image = isHeartFilled ? CellConsts.hearthFilled : CellConsts.hearthEmpty
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        let tapHeartGR = UITapGestureRecognizer(target: self, action: #selector(heartTap))
        likeImage.addGestureRecognizer(tapHeartGR)
        let tapCommentGR = UITapGestureRecognizer(target: self, action: #selector(commentTap))
        commentsImage.addGestureRecognizer(tapCommentGR)
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
            
            viewsCountLabel.widthAnchor.constraint(equalToConstant: 30),
            viewsCountLabel.centerYAnchor.constraint(equalTo: viewsImage.centerYAnchor),
            viewsCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(with: RealmNews) {
        self.newsPostID = with.postId
        self.newsOwnerID = with.sourceId
        likeCountLabel.text = formattedCounter(with.likeCount)
        commentsCountLabel.text = formattedCounter(with.commentCount)
        repostCountLabel.text = formattedCounter(with.repostCount)
        viewsCountLabel.text = formattedCounter(with.viewsCount)
        likeImage.image = with.isDislike ? CellConsts.hearthFilled : CellConsts.hearthEmpty
    }
    
    @objc func heartTap() {
        setupAnimationHearth()
        delegate?.heartWasPressed(at: newsPostID)
    }
    
    @objc func commentTap() {
        delegate?.commentWasPressed(with: newsPostID, for: newsOwnerID)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeImage.image = CellConsts.hearthEmpty
        commentsImage.image = CellConsts.commentEmpty
        repostImage.image = CellConsts.repostEmpty
    }
    
    ///анимация лайка
    private func setupAnimationHearth() {
        let degree: Double = 180
        let rotationAngle = CGFloat(degree * Double.pi / 180)
        let rotaionTransform = CATransform3DMakeRotation(rotationAngle, 0, 1, 0)
        likeImage.layer.transform = rotaionTransform
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.likeImage.layer.transform = CATransform3DIdentity
        }
    }
    
    //MARK: - Setup Cell
    private struct CellConsts {
        static let hearthEmpty = UIImage(named: "hearth-no-fill")
        static let hearthFilled = UIImage(named: "hearth-fill")
        static let commentEmpty = UIImage(named: "comment")
        static let repostEmpty = UIImage(named: "repost")
        static let viewsEmpty = UIImage(named: "eye")
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
    
}
