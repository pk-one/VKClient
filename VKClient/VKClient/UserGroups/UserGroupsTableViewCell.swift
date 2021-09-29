//
//  UserGroupsTableViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class UserGroupsTableViewCell: UITableViewCell {
    @IBOutlet var imageGroupImageView: UIImageView!
    @IBOutlet var groupNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        let tapAvatar = UITapGestureRecognizer(target: self, action: #selector(tappedAvatar))
        imageGroupImageView.addGestureRecognizer(tapAvatar)
    }
    
    @objc private func tappedAvatar() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.8
        animation.toValue = 1
        animation.stiffness = 400
        animation.mass = 2
        animation.fillMode = .backwards
        animation.duration = 1
        imageGroupImageView.layer.add(animation, forKey: nil)
    }
    
    func configure(with: RealmGroups) {
        guard let avatar = with.avatar else { return }
        let url = URL(string: avatar)
        imageGroupImageView.kf.setImage(with: url)
        groupNameLabel.text = with.name
    }
}
