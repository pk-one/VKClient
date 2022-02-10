//
//  LikeControl.swift
//  VKClient
//
//  Created by Pavel Olegovich on 30.07.2021.
//

import UIKit

class CustomLikeControl: UIControl {
   
    var countLikes: Int = 0 {
        didSet {
            likesCountLabel.text = "\(countLikes)"
        }
    }

    private var isLiked = false
    
    private var likesCountLabel: UILabel = {
        let likesCountLabel = UILabel()
        likesCountLabel.textColor = .standardWhite
        likesCountLabel.translatesAutoresizingMaskIntoConstraints = false
        return likesCountLabel
    }()
    
    private var likeButton: UIButton = {
        let likeButton = UIButton(type: .custom)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return likeButton
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private var hearthPath: UIBezierPath = {
        let hearthPath = UIBezierPath()
        hearthPath.move(to: CGPoint(x: 12.43, y: 7.9))
        hearthPath.addCurve(to: CGPoint(x: 3.02, y: 5.08), controlPoint1: CGPoint(x: 12.43, y: 7.9), controlPoint2: CGPoint(x: 7.81, y: -0.75))
        hearthPath.addCurve(to: CGPoint(x: 6.24, y: 18.17), controlPoint1: CGPoint(x: 0.48, y: 8.18), controlPoint2: CGPoint(x: 3.09, y: 14.35))
        hearthPath.addCurve(to: CGPoint(x: 12.43, y: 23), controlPoint1: CGPoint(x: 9.03, y: 21.55), controlPoint2: CGPoint(x: 12.43, y: 23))
        hearthPath.addCurve(to: CGPoint(x: 18.61, y: 18.17), controlPoint1: CGPoint(x: 12.43, y: 23), controlPoint2: CGPoint(x: 16.01, y: 20.96))
        hearthPath.addCurve(to: CGPoint(x: 22.02, y: 5.27), controlPoint1: CGPoint(x: 22.01, y: 14.53), controlPoint2: CGPoint(x: 24.45, y: 8.86))
        hearthPath.addCurve(to: CGPoint(x: 12.43, y: 7.9), controlPoint1: CGPoint(x: 17.73, y: -1.07), controlPoint2: CGPoint(x: 12.43, y: 7.9))
        hearthPath.lineWidth = 2
        hearthPath.close()
        return hearthPath
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseUI()
        setShapeLayer(color: .standardWhite)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBaseUI()
        setShapeLayer(color: .standardWhite)
    }
    
    @objc private func didTapButton() {
        isLiked = !isLiked
        likesCountLabel.text = isLiked ? "\(countLikes + 1)" : "\(countLikes)"
        if isLiked {
            likesCountLabel.textColor = .standardRed
            setShapeLayer(color: .standardRed)
        } else {
            setShapeLayer(color: .standardWhite)
            likesCountLabel.textColor = .standardBlack
        }
    }
    
    private func setupBaseUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(likesCountLabel)
        NSLayoutConstraint.activate([
            likeButton.widthAnchor.constraint(equalToConstant: 25),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setShapeLayer(color: UIColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = color.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.path = hearthPath.cgPath
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.8
        animation.toValue = 1
        animation.stiffness = 400
        animation.mass = 2
        animation.fillMode = .backwards
        animation.duration = 1
        likeButton.layer.addSublayer(shapeLayer)
        likeButton.layer.add(animation, forKey: nil)
    }
}
