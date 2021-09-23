//
//  NewsTableHeaderView.swift
//  VKClient
//
//  Created by Pavel Olegovich on 19.09.2021.
//

import UIKit
import Kingfisher
import RealmSwift

class NewsTableHeaderView: UITableViewHeaderFooterView {
    private var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy' 'HH:mm"
        return df
    }()
    
    private var postAuthor: UILabel = {
        let postAuthor = UILabel()
        postAuthor.font = UIFont(name: "Arial", size: 15)
        postAuthor.translatesAutoresizingMaskIntoConstraints = false
        return postAuthor
    }()
    
    private var authorImageView: UIImageView = {
        let authorImageView = UIImageView()
        authorImageView.translatesAutoresizingMaskIntoConstraints = false
        authorImageView.contentMode = .scaleAspectFill
        authorImageView.layer.masksToBounds = true
        authorImageView.layer.cornerRadius = 25
        return authorImageView
    }()
    
    private var postDate: UILabel = {
        let postDate = UILabel()
        postDate.font = UIFont(name: "Arial", size: 11)
        postDate.translatesAutoresizingMaskIntoConstraints = false
        return postDate
    }()
    
    private var headerView: UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemBackground
        return headerView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(headerView)
        headerView.addSubview(authorImageView)
        headerView.addSubview(postAuthor)
        headerView.addSubview(postDate)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leftAnchor.constraint(equalTo: leftAnchor),
            headerView.rightAnchor.constraint(equalTo: rightAnchor),
            headerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            authorImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            authorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            authorImageView.widthAnchor.constraint(equalToConstant: 50),
            authorImageView.heightAnchor.constraint(equalToConstant: 50),
            
            postAuthor.leftAnchor.constraint(equalTo: authorImageView.rightAnchor, constant: 10),
            postAuthor.bottomAnchor.constraint(equalTo: authorImageView.centerYAnchor),
            postAuthor.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            postDate.topAnchor.constraint(equalTo: postAuthor.bottomAnchor),
            postDate.leftAnchor.constraint(equalTo: authorImageView.rightAnchor, constant: 10)
            
        ])
    }
    
    func configure(news: RealmNews, groups: Results<RealmGroups>, friends: Results<RealmFriends>) {
                if news.sourceId < 0 {
                    var idNews = news.sourceId
                    idNews.negate()
                    for i in 0..<groups.count where idNews == groups[i].id {
                        postAuthor.text = groups[i].name
                        guard let avatar = groups[i].avatar else { return }
                        let url = URL(string: avatar)
                        authorImageView.kf.setImage(with: url)
                    }
                } else {
                    for i in 0..<friends.count where news.sourceId == friends[i].id {
                        postAuthor.text = "\(friends[i].firstName) \(friends[i].lastName)"
                        guard let avatar = groups[i].avatar else { return }
                        let url = URL(string: avatar)
                        authorImageView.kf.setImage(with: url)
                    }
                }
        postDate.text = dateFormatter.string(from: news.date)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorImageView.image = nil
        self.postAuthor.text = nil
        self.postDate.text = nil
    }
}
