//
//  RoundedImageView.swift
//  VKClient
//
//  Created by Pavel Olegovich on 29.07.2021.
//

import UIKit

class RoundedImageView: UIImageView {

    override init(frame: CGRect){
        super.init(frame: frame)
        RoundedImageView()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        RoundedImageView()
    }
    
    private func RoundedImageView() {
        layer.cornerRadius = 25
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
   
}
