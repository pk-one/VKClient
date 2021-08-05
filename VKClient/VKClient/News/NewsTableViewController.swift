//
//  NewsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 03.08.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    let news = News.allPostCases
    private var selectedLike = [IndexPath : Bool]()
    private var selectedComment = [IndexPath : Bool]()
    private var selectedReposts = [IndexPath : Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return News.allPostCases.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.headerNewsImageView.image = UIImage(named: news[indexPath.row].imageHeaderNews)
        cell.newsAuthorNameLabel.text = news[indexPath.row].nameAuthorNews
        cell.timeNewsLabel.text = news[indexPath.row].timeNews
        cell.textNewsLabel.text = news[indexPath.row].textNews
        cell.countLikesLabel.text = String(news[indexPath.row].countLikeNews)
        cell.countCommentsLabel.text = String(news[indexPath.row].countCommentsNews)
        cell.countRepostsLabel.text = String(news[indexPath.row].countRepostsNews)
        cell.countViewsLabel.text = String(news[indexPath.row].countViewsNews)
        ///изображения
        if let images = news[indexPath.row].imageNews, !images.isEmpty {
            cell.newsImagesCollectionView.set(photos: images)
        }
        ///лайки
        if let stateHeart = selectedLike[indexPath] {
            cell.isHeartFilled = stateHeart
        }
        cell.heartWasPressed = { [weak self] in
            self?.selectedLike[indexPath] = cell.isHeartFilled
        }
        ////коменты
        if let stateComment = selectedComment[indexPath] {
            cell.isCommentTap = stateComment
        }
        cell.commentWasPressed = { [weak self] in
            self?.selectedComment[indexPath] = cell.isCommentTap
        }
        ///репост
        if let stateRepost = selectedReposts[indexPath] {
            cell.isRepostTap = stateRepost
        }
        cell.repostWasPressed = { [weak self] in
            self?.selectedReposts[indexPath] = cell.isRepostTap
        }
        return cell
    }
}
