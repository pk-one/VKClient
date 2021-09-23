//
//  NewsViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 11.08.2021.
//

import UIKit
import RealmSwift
import Kingfisher

class NewsViewController: UIViewController {
    ///MARK: Outlets

    @IBOutlet var vkLoaderView: VKLoaderView!
    
    private var news: Results<RealmNews>?
    private var friends: Results<RealmFriends>?
    private var groups: Results<RealmGroups>?
    private var imageWithCell: UIImage?
    
    private var selectedLike = [IndexPath : Bool]()
    private var selectedComment = [IndexPath : Bool]()
    private var selectedReposts = [IndexPath : Bool]()
    
    private let networkService: NetworkService = NetworkServiceImplementation()
    private let databaseService: DatabaseService = DatabaseServiceImplementation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        
        networkService.getNews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let newsArray):
            _ = try? self.databaseService.save(newsArray)
            }
        }
        news = try? databaseService.get(RealmNews.self).sorted(byKeyPath: "date", ascending: false)
        friends = try? databaseService.get(RealmFriends.self)
        groups = try? databaseService.get(RealmGroups.self)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        table.register(NewsTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "NewsTableHeaderView")
        table.register(NewsTableFooterView.self, forHeaderFooterViewReuseIdentifier: "NewsTableFooterView")
        return table
    }()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
        tableView.frame = view.bounds.inset(by: UIEdgeInsets(top: 90, left: 0, bottom: 80, right: 0))
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NewsTableHeaderView") as? NewsTableHeaderView
        guard let news = news, let groups = groups, let friends = friends else { return UIView()}
        headerView?.configure(news: news[section], groups: groups, friends: friends)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NewsTableFooterView") as? NewsTableFooterView
        guard let news = news else { return UIView() }
        footerView?.configure(with: news[section])
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let news = news else { return 0 }
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
        guard let news = news else { return UITableViewCell() }
        cell.configure(model: news[indexPath.section], indexPath: indexPath)
        return cell
    }
}
