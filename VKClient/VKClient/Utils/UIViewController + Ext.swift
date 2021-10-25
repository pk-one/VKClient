//
//  UIViewController + Ext.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.09.2021.
//

import UIKit

extension UIViewController {
    func show(error: Error) {
        let alertController = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
}
