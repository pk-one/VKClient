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
    
    func configure(with: Groups) {
        let url = URL(string: with.avatar)
        imageGroupImageView.kf.setImage(with: url)
        nameGroupLabel.text = with.name
    }
}
