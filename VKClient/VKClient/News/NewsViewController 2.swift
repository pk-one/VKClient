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
        newsTableView.tableFooterView = UIView()
        newsTableView.allowsSelection = false
        newsTableView.isHidden = true
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.estimatedRowHeight = 44
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) { [self] in
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(NewsTableViewCell.self, for: indexPath)
        cell.configure(with: news[indexPath.row])
        cell.indexPath = indexPath.row
        cell.delegate = self
        cell.configureIndexPath(with: indexPath)
        ///изображения
        if let images = news[indexPath.row].imageNews, !images.isEmpty {
            cell.newsImagesCollectionView.set(photos: images)
        }
        ///лайки
        if let stateHeart = selectedLike[indexPath] {
            cell.isHeartFilled = stateHeart
        }
        ////коменты
        if let stateComment = selectedComment[indexPath] {
            cell.isCommentTap = stateComment
        }
        ///репост
        if let stateRepost = selectedReposts[indexPath] {
            cell.isRepostTap = stateRepost
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

extension NewsViewController: NewsTableViewCellDelegate {
    func heartWasPressed(in indexPath: IndexPath, and isSelected: Bool) {
        selectedLike[indexPath] = isSelected
    }
    
    func commentWasPressed(in indexPath: IndexPath, and isSelected: Bool) {
        selectedComment[indexPath] = isSelected
    }
    
    func repostWasPressed(in indexPath: IndexPath, and isSelected: Bool) {
        selectedReposts[indexPath] = isSelected
    }
}

    
