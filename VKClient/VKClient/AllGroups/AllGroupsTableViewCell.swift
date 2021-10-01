//
//  AllGroupsTableViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

protocol AllGroupsTableViewCellDelegate: AnyObject {
    func addGroup(id: Int, name: String)
}

class AllGroupsTableViewCell: UITableViewCell {
    
    @IBOutlet var addGroupsButton: UIButton!
    
    @IBOutlet private var imageGroupImageView: UIImageView!
    @IBOutlet private var nameGroupLabel: UILabel!
    
    weak var delegate: AllGroupsTableViewCellDelegate?
    
    private var selectedID = 0
    private var selectedName: String?
    
    func configure(with: MyGroups) {
        selectedID = with.id
        selectedName = with.name
        let url = URL(string: with.avatar)
        imageGroupImageView.kf.setImage(with: url)
        nameGroupLabel.text = with.name
    }
    
    @IBAction func addGroupsButtonTapped(_ sender: UIButton) {
        guard let selectedName = selectedName else { return }
        self.delegate?.addGroup(id: selectedID, name: selectedName)
    }
}
