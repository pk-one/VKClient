//
//  NewsViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 11.08.2021.
//

import UIKit
import RealmSwift

class NewsViewController: UIViewController {
    ///MARK: Outlets

    @IBOutlet var vkLoaderView: VKLoaderView!
    
    private var news = [News]()
    private lazy var friends = try? databaseService.get(RealmFriends.self)
    private lazy var groups = try? databaseService.get(RealmGroups.self)
    
    private var selectedLike = [IndexPath : Bool]()
    private var selectedComment = [IndexPath : Bool]()
    private var selectedReposts = [IndexPath : Bool]()
    
    private let networkService: NetworkService = NetworkServiceImplementation()
    private let databaseService: DatabaseService = DatabaseServiceImplementation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88.0

        networkService.getNews(completionHandler: { [weak self] news in
            guard let self = self else { return }
            self.news = news
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
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
        tableView.frame = view.bounds
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NewsTableHeaderView") as? NewsTableHeaderView
        guard let groups = groups, let friends = friends else { return UIView()}
        headerView?.configure(news: news[section], groups: groups, friends: friends)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NewsTableFooterView") as? NewsTableFooterView
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
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = news[section]
        
        if model.imageNews.isEmpty && model.textNews.isEmpty {
            return 0
        } else if !model.imageNews.isEmpty && !model.textNews.isEmpty {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell  else { return UITableViewCell() }
        cell.configure(model: news[indexPath.section], indexPath: indexPath)
        return cell
    }
}
