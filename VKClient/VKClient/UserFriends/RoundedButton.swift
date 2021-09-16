//
//  RoundedButton.swift
//  VKClient
//
//  Created by Pavel Olegovich on 16.09.2021.
//

import UIKit

class RoundedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        RoundedButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        RoundedButton()
    }
    
    private func RoundedButton() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }

}
