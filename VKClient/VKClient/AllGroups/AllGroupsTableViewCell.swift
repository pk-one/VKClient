//
//  AllGroupsTableViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class AllGroupsTableViewCell: UITableViewCell {
    
    @IBOutlet private var imageGroupImageView: UIImageView!
    @IBOutlet private var nameGroupLabel: UILabel!
    @IBOutlet private var descriptionGroupLabel: UILabel!
    
    func configure(with: Group) {
        imageGroupImageView.image = UIImage(named: with.image)
        nameGroupLabel.text = with.groupName
        descriptionGroupLabel.text = with.description
    }
}
