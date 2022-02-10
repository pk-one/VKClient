//
//  SplashViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 09.11.2021.
//

import UIKit

class SplashViewController: UIViewController {

    var logoIsHidden: Bool = false
    
    static var logoImage = UIImage(named: "VK-Logo-2016")
    
//MARK: - Properties
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = logoImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

//MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(logoImageView)
        logoImageView.isHidden = logoIsHidden
        setConstraint()
    }
}

//MARK: - setConstraint
extension SplashViewController {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
}
