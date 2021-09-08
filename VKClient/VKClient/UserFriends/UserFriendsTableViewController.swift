//
//  UserFriendsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class UserFriendsTableViewController: UITableViewController {
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var cancelSearchButton: UIButton!
    @IBOutlet var centerXContraintMagnifyingGlass: NSLayoutConstraint!
    @IBOutlet var trailingConstraintSearchTextField: NSLayoutConstraint!
    
    private var groupsUser = groupUsersByFirstLetter()
    private var textSearch: String = "" {
        didSet {
            groupsUser = groupUsersByFirstLetter(textSearch: textSearch)
        }
    }
    private let networkService: NetworkService =  NetworkServiceImplementation()
    private var token = SessionInfo.shared.token!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///добавляем аватарку юзера в колекцию фоток
        addAvatarForCollectionPhotos()
        ///убираем лишние ячейки
        tableView.tableFooterView = UIView()
        self.navigationController?.view.addSubview(lettersControl)
        lettersControl.addTarget(self, action: #selector(lettersChange(_:)), for: .valueChanged)
        setupSearchBar()
        setupButton()
        networkService.getFriends(token: token)
    }
    
    private let lettersControl: LettersControl = {
        let lettersControl = LettersControl()
        lettersControl.translatesAutoresizingMaskIntoConstraints = false
        return lettersControl
    }()
    ///показываем контрол букв
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.view.layoutIfNeeded()
        lettersControl.isHidden = false
    }
    ///убираем контрол букв
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        lettersControl.isHidden = true
        searchTextField.resignFirstResponder()
    }
    ///считаем положение контрола
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupControl()
    }
    ///скролл до нужно секции
    @objc private func lettersChange(_ control: LettersControl){
        let indexPath = IndexPath(item: 0, section: control.selectedLetter!)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupsUser.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsUser[section].users.count
    }
    //анимация загрузки ячеек
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let degree: Double = 90
        let rotationAngle = CGFloat(degree * Double.pi / 180)
        let rotaionTransform = CATransform3DMakeRotation(rotationAngle, 1, 0, 0)
        cell.layer.transform = rotaionTransform
        
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseInOut) {
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(UserFriendsTableViewCell.self, for: indexPath )
        let user = self.groupsUser[indexPath.section].users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SegueFriendPhoto",
              let source = segue.source as? UserFriendsTableViewController,
              let destination = segue.destination as? FriendsPhotosCollectionViewController,
              let indexPath = source.tableView.indexPathForSelectedRow else { return }
        let user = self.groupsUser[indexPath.section].users[indexPath.row]
        destination.photos = user.photos
    }
    ///задаем название секции и перерисовываем
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.alpha = 0.5
        let label = UILabel()
        label.text = groupsUser[section].firstLetter
        label.font = UIFont(name: "Arial", size: 15)
        label.textColor = UIColor.black
        label.frame = CGRect(x: 25, y: 7, width: 100, height: 15)
        view.addSubview(label)
        return view
    }
    ///метод добавление аватарки в коллекцию фоток
//    private func addAvatarForCollectionPhotos() {
//        var users = groupsUser
//            .flatMap { $0.users }
//            .filter { $0.avatarImage != "noavatar" }
//
//        for (index, _) in users.enumerated() {
//            users[index].photos.append(users[index].avatarImage)
//        }
//    }
    private func addAvatarForCollectionPhotos() {
        for (_, sectionItem) in groupsUser.enumerated() {
            for (userIndex, _) in sectionItem.users.enumerated() {
                if sectionItem.users[userIndex].avatarImage != "noavatar" {
                    sectionItem.users[userIndex].photos.append(sectionItem.users[userIndex].avatarImage)
                }
            }
        }
    }
    
    private func setupControl() {
        let controlSize = lettersControl.bounds.size
        let xPosition = view.frame.maxX - controlSize.width
        let yPosition = view.frame.midY - (controlSize.height / 2)
        let origin = CGPoint(x: xPosition, y: yPosition)
        lettersControl.frame = CGRect(origin: origin, size: controlSize)
    }
    
    private func setupButton() {
        cancelSearchButton.layer.cornerRadius = 4
    }
    
    private func setupSearchBar() {
        searchTextField.addTarget(self, action: #selector(editingBegan(_:)), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        cancelSearchButton.addTarget(self, action: #selector(touchCancel(_:)), for: .touchUpInside)
    }
    
    @objc private func editingBegan(_ textField: UITextField) {
        let widthSearchField = searchTextField.bounds.size.width
        let widthCancelButton = cancelSearchButton.bounds.size.width
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.trailingConstraintSearchTextField.constant += 70
            self.view.layoutIfNeeded()
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
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func touchCancel(_ sender: UIButton) {
        let widthSearchField = searchTextField.bounds.size.width
        let widthCancelButton = cancelSearchButton.bounds.size.width
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.cancelSearchButton.alpha = 0
            self.textSearch = ""
            self.searchTextField.text = ""
            self.searchTextField.resignFirstResponder()
            self.tableView.reloadData()
            self.addAvatarForCollectionPhotos()
            self.view.layoutIfNeeded()
        }) {_ in
            UIView.animate(withDuration: 0.3) {
                self.trailingConstraintSearchTextField.constant -= 70
                self.view.layoutIfNeeded()
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
        guard searchTextField.text != "" else { return }
        self.textSearch = searchTextField.text!
        self.tableView.reloadData()
        addAvatarForCollectionPhotos()
    }
}
