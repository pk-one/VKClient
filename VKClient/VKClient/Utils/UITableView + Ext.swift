//
//  UITableView + Ext.swift
//  VKClient
//
//  Created by Pavel Olegovich on 18.11.2021.
//

import Foundation
import UIKit

extension UITableView
{
    func updateRow(row: Int, section: Int)
    {
        let indexPath = IndexPath(row: row, section: section)

        self.beginUpdates()
        self.reloadRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        self.endUpdates()
    }

}
