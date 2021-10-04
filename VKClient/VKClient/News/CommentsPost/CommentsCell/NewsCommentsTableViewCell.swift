//
//  NewsCommentsTableViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.09.2021.
//

import UIKit
import Kingfisher
import RealmSwift

class NewsCommentsTableViewCell: UITableViewCell {
    
    private var commentView: UIView = {
        let commentView = UIView()
        commentView.translatesAutoresizingMaskIntoConstraints = false
        commentView.backgroundColor = .systemBackground
        return commentView
    }()
    
    private let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textCommentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dateCommentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy' 'HH:mm"
        return df
    }()
    
    private func setupUI() {
        self.addSubview(commentView)
        commentView.addSubview(authorImageView)
        commentView.addSubview(authorNameLabel)
        commentView.addSubview(textCommentLabel)
        
        NSLayoutConstraint.activate([
            commentView.topAnchor.constraint(equalTo: topAnchor),
            commentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            commentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            commentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            authorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            authorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            authorImageView.widthAnchor.constraint(equalToConstant: 40),
            authorImageView.heightAnchor.constraint(equalToConstant: 40),
            
            authorNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 5),
            authorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            textCommentLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor),
            textCommentLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 5),
            textCommentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
        ])
        if commentImageView.image != nil {
            createImagePost()
            createDatePostLabel()
            commentImageView.bottomAnchor.constraint(equalTo: dateCommentLabel.topAnchor, constant: -5).isActive = true
        } else {
            createDatePostLabel()
            dateCommentLabel.topAnchor.constraint(equalTo: textCommentLabel.bottomAnchor, constant: 5).isActive = true
        }
    }
    
    func configure(comments: RealmNewsfeedComments, users: Results<RealmCommentsUsers>, groups: Results<RealmCommentsGroups>) {

        if comments.fromId < 0 {
            var idComments = comments.fromId
            idComments.negate()
            for i in 0..<groups.count where idComments == groups[i].id {
                authorNameLabel.text = groups[i].name
                let url = URL(string: groups[i].avatar)
                authorImageView.kf.setImage(with: url)
            }
        } else {
            for i in 0..<users.count where comments.fromId == users[i].id {
                authorNameLabel.text = "\(users[i].fullName)"
                let url = URL(string: users[i].avatar)
                authorImageView.kf.setImage(with: url)
            }
        }
        textCommentLabel.text = comments.text
        dateCommentLabel.text = dateFormatter.string(from: comments.date)
        
        guard let image = comments.image else { return }
        let url = URL(string: image)
        commentImageView.kf.setImage(with: url)
        setupUI()
    }
    
    private func createImagePost() {
        commentView.addSubview(commentImageView)
        NSLayoutConstraint.activate([
            commentImageView.topAnchor.constraint(equalTo: textCommentLabel.bottomAnchor, constant: 5),
            commentImageView.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 5),
            commentImageView.widthAnchor.constraint(equalToConstant: 100),
            commentImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func createDatePostLabel() {
        commentView.addSubview(dateCommentLabel)
        NSLayoutConstraint.activate([
            dateCommentLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 5),
            dateCommentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            dateCommentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textCommentLabel.text = nil
        self.commentImageView.image = nil
    }
}
