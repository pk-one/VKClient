//
//  SurveyFriendsPhotoViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 14.08.2021.
//

import UIKit

class SurveyFriendsPhotoViewController: UIViewController {
    
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    
    var photos: [String]!
    var index = 0
    
    private enum PanDirection {
        case middle
        case right
        case left
    }
    
    //rivate let transformZero = CGAffineTransform(scaleX: 0.0, y: 0.0)
    private let transformIncrease = CGAffineTransform(scaleX: 1.15, y: 1.15)
    
    private var panGesture = UIPanGestureRecognizer()
    private var currentPanGestureDirection: PanDirection = .middle
    
    private var currentPhotoImageView = UIImageView()
    private var nextPhotoImageView = UIImageView()
    
    private var nextPhotoIndex: Int {
        var photoIndex = 0
        if currentPanGestureDirection == .left {
            photoIndex = index + 1
            if photoIndex > self.photos.count - 1 {
                photoIndex = 0
            }
        } else if currentPanGestureDirection == .right {
            photoIndex = index - 1
            if photoIndex < 0 {
               photoIndex = self.photos.count - 1
            }
        }
        return photoIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        currentPhotoImageView = firstImageView
        nextPhotoImageView = secondImageView
        
        nextPhotoImageView.alpha = 0
        nextPhotoImageView.transform = .identity
        
        currentPhotoImageView.image = UIImage(named: photos[index])
        nextPhotoImageView.image = UIImage(named: photos[nextPhotoIndex])
        
        if photos.count > 1 {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.view.addGestureRecognizer(panGesture)
        }
        self.title = "\(index + 1) из \(photos.count)"
    }
    
    @objc private func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animatePhotoWithTransform(transformIncrease)
        case .changed:
            let translation = recognizer.translation(in: self.view)
            currentPanGestureDirection = translation.x > 0 ? .right : .left
            animatePhotoImageViewChanged(with: translation)
        case .ended:
            animatePhotoImageViewEnd()
        default: return
        }
    }
    
    private func animatePhotoWithTransform(_ transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.3) {
            self.currentPhotoImageView.transform = transform
        }
    }
    
    private func animatePhotoImageViewChanged(with translation: CGPoint) {
        currentPhotoImageView.transform = CGAffineTransform(translationX: translation.x, y: 0).concatenating(transformIncrease)
    }
    
    private func animatePhotoImageViewEnd() {
        if currentPanGestureDirection == .left {
            
            if currentPhotoImageView.frame.maxX < view.center.x {
                animatePhotoSwap()
            } else {
                self.currentPhotoImageView.transform = .identity
            }
        } else if currentPanGestureDirection == .right {
           
            if currentPhotoImageView.frame.maxX > view.center.x {
                animatePhotoSwap()
            } else {
                self.currentPhotoImageView.transform = .identity
            }
        }
    }
    
    private func animatePhotoSwap() {
        self.nextPhotoImageView.image = UIImage(named: photos[nextPhotoIndex])
        
        UIView.animate(withDuration: 0.5) {
            self.currentPhotoImageView.alpha = 0
            self.nextPhotoImageView.alpha = 1
            self.nextPhotoImageView.transform = .identity
            
        } completion: { _ in
            
            self.reconfigureImages()
        }
    }
    
    private func reconfigureImages() {
        index = nextPhotoIndex
        currentPhotoImageView.transform = CGAffineTransform.identity
        self.title = "\(index + 1) из \(photos.count)"

        if currentPhotoImageView == firstImageView {
            currentPhotoImageView = secondImageView
            nextPhotoImageView = firstImageView
        } else if currentPhotoImageView == secondImageView {
            currentPhotoImageView = firstImageView
            nextPhotoImageView = secondImageView
        }
    }
}
