//
//  AllGroupsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit


class AllGroupsTableViewController: UITableViewController {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var cancelSearchButton: UIButton!
    @IBOutlet var centerXContraintMagnifyingGlass: NSLayoutConstraint!
    @IBOutlet var trailingConstraintSearchTextField: NSLayoutConstraint!
    
    private var searchGroups = [GroupsItems]()
    private var operation: GetSearchGroupProtocol!
    private var serviceProxy: GetSearchGroupProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        operation = DataOperation()
        serviceProxy = GetSearchGroupProxy(service: operation)
        setupSearchBar()
        setupButton()
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(AllGroupsTableViewCell.self, for: indexPath)
        cell.configure(with: searchGroups[indexPath.row])
        return cell
    }
    
    private func setupSearchBar() {
        searchTextField.addTarget(self, action: #selector(editingBegan(_:)), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        cancelSearchButton.addTarget(self, action: #selector(touchCancel(_:)), for: .touchUpInside)
    }
    
    private func setupButton() {
        cancelSearchButton.layer.cornerRadius = 4
    }
    
    @objc private func editingBegan(_ textField: UITextField) {
        let widthSearchField = searchTextField.bounds.size.width
        let widthCancelButton = cancelSearchButton.bounds.size.width
        UIView.animate(withDuration: 0.3) {
            self.trailingConstraintSearchTextField.constant += 70
        }
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        self.centerXContraintMagnifyingGlass.constant += (widthSearchField / 2) - widthCancelButton - 30
                        self.view.layoutIfNeeded()
                       })
        UIView.animate(withDuration: 0.5, delay: 0.3) {
            self.cancelSearchButton.alpha = 1
        }
    }
    
    @objc private func touchCancel(_ sender: UIButton) {
        let widthSearchField = searchTextField.bounds.size.width
        let widthCancelButton = cancelSearchButton.bounds.size.width
        UIView.animate(withDuration: 0.3, animations: {
            self.cancelSearchButton.alpha = 0
            self.searchTextField.text = ""
            self.searchTextField.resignFirstResponder()
            self.searchGroups.removeAll()
            self.tableView.reloadData()
        }) {_ in
            UIView.animate(withDuration: 0.3) {
                self.trailingConstraintSearchTextField.constant -= 70
            }
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                            self.centerXContraintMagnifyingGlass.constant -= widthSearchField / 2 - widthCancelButton + 5
                            self.view.layoutIfNeeded()
                           })
        }
    }
    
    @objc private func editingChanged(_ sender: UITextField) {
        guard let textSearch = searchTextField.text else { return }
        serviceProxy?.getGroupSearch(textSearch: textSearch) { [weak self] searchGroups in
            self?.searchGroups = searchGroups
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}


