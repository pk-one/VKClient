//
//  AllGroupsTableViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class AllGroupsTableViewCell: UITableViewCell {
    @IBOutlet var imageGroupImage: UIImageView!
    @IBOutlet var nameGroupLabel: UILabel!
    @IBOutlet var descriptionGroupLabel: UILabel!
    @IBOutlet var countFollowGroupLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
