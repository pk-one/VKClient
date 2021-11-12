//
//  NewsCommentsViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.09.2021.
//

import UIKit
import RealmSwift
import Kingfisher

class NewsCommentsViewController: UIViewController {
    
    private var dataOperation = DataOperation()
    private var databaseService: DatabaseService = DatabaseServiceImplementation()
    
    private lazy var friends = try? databaseService.get(RealmFriends.self)
    private lazy var groups = try? databaseService.get(RealmGroups.self)
    private lazy var news = try? databaseService.get(RealmNews.self, primaryKey: postID)
    
    //проперти для самих коментов
    private var currentComments: Results<RealmNewsfeedComments>?
    private var usersComments: Results<RealmCommentsUsers>?
    private var groupsComments: Results<RealmCommentsGroups>?
    
    private var notificationTokenInfo: NotificationToken?
    private var notificationTokenUsers: NotificationToken?
    private var notificationTokenGroups: NotificationToken?
    
    private let token = SessionInfo.shared.token
    
    var ownerID = 0
    var postID = 0
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(NewsCommentsTableViewCell.self, forCellReuseIdentifier: "NewsCommentsTableViewCell")
        table.register(NewsPostTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "NewsPostTableHeaderView")
        table.register(NewsPostTableViewCell.self, forCellReuseIdentifier: "NewsPostTableViewCell")
        table.register(NewsPostTableFooterView.self, forHeaderFooterViewReuseIdentifier: "NewsPostTableFooterView")
        return table
    }()
    
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
        
        print(token)
        fetchComments()
        
        notificationTokenInfo = currentComments?.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .error(let error):
                self.show(error: error)
            case .initial:
                self.tableView.reloadData()
            case .update:
                self.tableView.reloadData()
            }
        }
        // токен юзеров в коментарии
        notificationTokenUsers = usersComments?.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .error(let error):
                self.show(error: error)
            case .initial:
                self.tableView.reloadData()
            case .update:
                self.tableView.reloadData()
            }
        }
        //токен групп в коменте
        notificationTokenGroups = groupsComments?.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .error(let error):
                self.show(error: error)
            case .initial:
                self.tableView.reloadData()
            case .update:
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        tableView.frame = view.bounds
        tableView.frame = view.bounds.inset(by: UIEdgeInsets(top: 90, left: 0, bottom: 80, right: 0))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationTokenInfo?.invalidate()
        notificationTokenUsers?.invalidate()
        notificationTokenGroups?.invalidate()
    }
    
    private func fetchComments() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        
        dataOperation.getComments(ownerId: ownerID, postId: postID)
        
        dataOperation.getUsersComments(ownerId: ownerID, postId: postID)
        
        dataOperation.getGroupsComments(ownerId: ownerID, postId: postID)
        
        usersComments = try? databaseService.get(RealmCommentsUsers.self)
        groupsComments = try? databaseService.get(RealmCommentsGroups.self)
        currentComments = try? databaseService.get(RealmNewsfeedComments.self).filter("postId == %@", postID)

        activityIndicator.stopAnimating()
        self.tableView.reloadData()
    }
}

extension NewsCommentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            guard let news = news else {
                return UITableView.automaticDimension
            }
                let model = news
            
                if  !model.imageNews.isEmpty && model.textNews.isEmpty && indexPath.row == 0 {
                    let height = CGFloat(model.imageSizeHeight*Int(view.bounds.width)/model.imageSizeWidth)
                    return height + 5
                } else if !model.imageNews.isEmpty && !model.textNews.isEmpty && indexPath.row == 1 {
                    let height = CGFloat(model.imageSizeHeight*Int(view.bounds.width)/model.imageSizeWidth)
                    return height + 5
                }
                return UITableView.automaticDimension
            } else {
                return UITableView.automaticDimension
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            guard let news = news else { return 0 }
            let model = news
            
            if model.imageNews.isEmpty && model.textNews.isEmpty {
                return 0
            } else if !model.imageNews.isEmpty && !model.textNews.isEmpty {
                return 2
            }
            return 1
        } else {
            return currentComments?.count ?? 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(NewsPostTableHeaderView.self)
            guard let news = news, let groups = groups, let friends = friends else { return UIView()}
            headerView.configure(news: news, groups: groups, friends: friends)
            return headerView
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let footerView = tableView.dequeueReusableHeaderFooterView(NewsPostTableFooterView.self)
            guard let news = news else { return UIView() }
            footerView.configure(with: news)
            footerView.delegate = self
            return footerView
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 60
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cellPost = tableView.dequeueReusableCell(NewsPostTableViewCell.self, for: indexPath)
            guard let news = news else { return UITableViewCell() }
            cellPost.configure(model: news, indexPath: indexPath)
            return cellPost
        } else {
            let cellComments = tableView.dequeueReusableCell(NewsCommentsTableViewCell.self, for: indexPath)
            guard let currentComments = currentComments, let usersComments = usersComments, let groupsComments = groupsComments else { return UITableViewCell() }
            cellComments.configure(comments: currentComments[indexPath.row], users: usersComments, groups: groupsComments)
            return cellComments
        }
    }
}
extension NewsCommentsViewController: NewsPostTableFooterViewDelegate {
    func heartWasPressed(at objectId: Int) {
        guard let object = try? databaseService.get(RealmNews.self, primaryKey: objectId) else { return }
        let realm = try! Realm()
        try? realm.write {
            object.isDislike.toggle()
        }
    }
}
