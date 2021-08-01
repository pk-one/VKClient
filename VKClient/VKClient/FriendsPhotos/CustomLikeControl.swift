//
//  LikeControl.swift
//  VKClient
//
//  Created by Pavel Olegovich on 30.07.2021.
//

import UIKit

class CustomLikeControl: UIControl {

    private var isLiked = false
    
    private var likesCountLabel: UILabel = {
        let likesCountLabel = UILabel()
        likesCountLabel.text = "0"
        likesCountLabel.textColor = UIColor.white
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
        stackView.distribution = .fillEqually
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
        setShapeLayer(color: UIColor.white)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBaseUI()
        setShapeLayer(color: UIColor.white)
    }
    
    @objc private func didTapButton() {
        isLiked = !isLiked
        likesCountLabel.text = isLiked ? "1" : "0"
        if isLiked {
            setShapeLayer(color: UIColor.red)
            likesCountLabel.textColor = UIColor.red
        } else {
            setShapeLayer(color: UIColor.white)
            likesCountLabel.textColor = UIColor.black
        }
    }
    
    private func setupBaseUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(likesCountLabel)
        NSLayoutConstraint.activate([
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
        likeButton.layer.addSublayer(shapeLayer)
    }
}
