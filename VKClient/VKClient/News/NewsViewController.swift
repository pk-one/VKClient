//
//  NewsViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 11.08.2021.
//

import UIKit

class NewsViewController: UIViewController {
    ///MARK: Outlets

    @IBOutlet var newsTableView: UITableView!
    @IBOutlet var vkLoaderView: VKLoaderView!
    let news = News.allPostCases
    private var selectedLike = [IndexPath : Bool]()
    private var selectedComment = [IndexPath : Bool]()
    private var selectedReposts = [IndexPath : Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.tableFooterView = UIView()
        newsTableView.allowsSelection = false
        newsTableView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.6) { [self] in
            UIView.transition(from: vkLoaderView, to: newsTableView, duration: 0.5, options: .transitionCrossDissolve) { _ in
                vkLoaderView.removeFromSuperview()
            }
            newsTableView.isHidden = false
        }
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return News.allPostCases.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.headerNewsImageView.image = UIImage(named: news[indexPath.row].imageHeaderNews)
        cell.newsAuthorNameLabel.text = news[indexPath.row].nameAuthorNews
        cell.timeNewsLabel.text = news[indexPath.row].timeNews
        cell.textNewsLabel.text = news[indexPath.row].textNews
        cell.countLikesLabel.text = formattedCounter(news[indexPath.row].countLikeNews)
        cell.countCommentsLabel.text = formattedCounter(news[indexPath.row].countCommentsNews)
        cell.countRepostsLabel.text = formattedCounter(news[indexPath.row].countRepostsNews)
        cell.countViewsLabel.text = formattedCounter(news[indexPath.row].countViewsNews)
        cell.indexPath = indexPath.row
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
