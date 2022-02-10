//
//  NewsViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 11.08.2021.
//

import UIKit
import RealmSwift
import Kingfisher

class NewsViewController: UIViewController{
    ///MARK: Outlets
    
    @IBOutlet var vkLoaderView: VKLoaderView!
    
    private lazy var groups = try? databaseService.get(RealmGroups.self)
    private lazy var friends = try? databaseService.get(RealmFriends.self)
    private lazy var allNews = try? self.databaseService.get(RealmNews.self).sorted(byKeyPath: "date", ascending: false)

    
    private var notificationToken: NotificationToken?
    private var myRefreshControll: UIRefreshControl = {
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControll
    }()
    
    private let dataOperation = DataOperation()
    private let databaseService: DatabaseService = DatabaseServiceImplementation()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        table.register(NewsTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "NewsTableHeaderView")
        table.register(NewsTableFooterView.self, forHeaderFooterViewReuseIdentifier: "NewsTableFooterView")
        return table
    }()
    
    private var selectedShowButtonsArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .secondarySystemBackground
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = myRefreshControll
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationToken = allNews?.observe { [weak self] change in
            switch change {
            case .error(let error):
                self?.show(error: error)
            case .initial:
                self?.tableView.reloadData()
            case .update:
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationToken?.invalidate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        tableView.frame = view.bounds
        tableView.frame = view.bounds.inset(by: UIEdgeInsets(top: 90, left: 0, bottom: 80, right: 0))
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        dataOperation.getNews()
        allNews = try? self.databaseService.get(RealmNews.self).sorted(byKeyPath: "date", ascending: false)
        sender.endRefreshing()
        self.tableView.reloadData()
    }
}


extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(NewsTableHeaderView.self)
        guard let allNews = allNews, let groups = groups, let friends = friends else { return UIView()}
        headerView.configure(news: allNews[section], groups: groups, friends: friends)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(NewsTableFooterView.self)
        guard let allNews = allNews else { return UIView() }
        footerView.configure(with: allNews[section])
        footerView.delegate = self
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allNews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let allNews = allNews else {
            return UITableView.automaticDimension
        }
        
        let model = allNews[indexPath.section]
        
        if  !model.imageNews.isEmpty && model.textNews.isEmpty && indexPath.row == 0 {
            let height = CGFloat(model.imageSizeHeight*Int(view.bounds.width)/model.imageSizeWidth)
            return height + 5
        } else if !model.imageNews.isEmpty && !model.textNews.isEmpty && indexPath.row == 1 {
            let height = CGFloat(model.imageSizeHeight*Int(view.bounds.width)/model.imageSizeWidth)
            return height + 5
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let news = allNews else { return 0 }
        let model = news[section]
        
        if model.imageNews.isEmpty && model.textNews.isEmpty {
            return 0
        } else if !model.imageNews.isEmpty && !model.textNews.isEmpty {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(NewsTableViewCell.self, for: indexPath)
        guard let allNews = allNews else { return UITableViewCell() }
        cell.configure(model: allNews[indexPath.section], indexPath: indexPath)
        cell.delegate = self
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

extension NewsViewController: NewsTableFooterViewDelegate, UINavigationControllerDelegate {
    func commentWasPressed(with postID: Int, for ownerID: Int) {
        guard let newsCommentsViewController = storyboard?.instantiateViewController(withIdentifier: "NewsCommentsViewController") as? NewsCommentsViewController else { return }
        newsCommentsViewController.modalPresentationStyle = .fullScreen
        newsCommentsViewController.postID = postID
        newsCommentsViewController.ownerID = ownerID
        navigationController?.delegate = self
        navigationController?.pushViewController(newsCommentsViewController, animated: true)
    }
    
    func heartWasPressed(at objectId: Int) {
        guard let object = try? databaseService.get(RealmNews.self, primaryKey: objectId) else { return }
        let realm = try! Realm()
        try? realm.write {
            object.isDislike.toggle()
        }
    }
}

extension NewsViewController: NewsTableViewCellDelegate {
    func showMoreTappedButton(indexPath: IndexPath, postId: Int) {
        self.selectedShowButtonsArray.append(postId)
        tableView.updateRow(row: indexPath.row, section: indexPath.section)
    }
}
