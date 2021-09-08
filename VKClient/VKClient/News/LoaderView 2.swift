//
//  LoaderView.swift
//  VKClient
//
//  Created by Pavel Olegovich on 11.08.2021.
//

import UIKit

class LoaderView: UIView {
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.spacing = 12
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    private func setUI() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        var delay = 0.0
        for _ in 0...2 {
            let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
            view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            view.layer.masksToBounds = true
            view.layer.cornerRadius = view.frame.width / 2
            view.alpha = 0
            UIView.animate(withDuration: 0.5,
                           delay: delay,
                           options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
                            view.alpha = 1
                           }, completion: nil)
            stackView.addArrangedSubview(view)
            delay += 0.16
        }
    }
}

