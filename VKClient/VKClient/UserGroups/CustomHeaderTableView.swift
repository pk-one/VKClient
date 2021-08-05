//
//  CustomHeaderTableView.swift
//  VKClient
//
//  Created by Pavel Olegovich on 04.08.2021.
//

import UIKit

class CustomHeaderTableView: UITableView {

    @IBOutlet var heightHeaderImageViewConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else { return }
        let offsetY = -contentOffset.y
        heightHeaderImageViewConstraint.constant = max(header.bounds.height, header.bounds.height + offsetY)
    }
}
