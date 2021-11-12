//
//  SurveyFriendsPhotoViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 14.08.2021.
//

import UIKit
import Kingfisher

class SurveyFriendsPhotoViewController: UIViewController {
    
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    
    var photos: [Photos]!
    var index = 0
    var selectedIndexPath: IndexPath?
    
    enum PanDirection {
        case middle
        case right
        case left
        case bottom
    }
    
    private let transformReduction = CGAffineTransform(scaleX: 0.6, y: 0.6)
    private let transformDefault = CGAffineTransform(scaleX: 1, y: 1)
    
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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.delegate = nil
        setupTapBar(hidden: false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupTapBar(hidden: true, animated: true)
    }
    
    private func setupViewController() {
        currentPhotoImageView = firstImageView
        nextPhotoImageView = secondImageView
        
        nextPhotoImageView.alpha = 0
        nextPhotoImageView.transform = transformReduction
        
        configurePhotos(with: photos[index], imageView: currentPhotoImageView)
        configurePhotos(with: photos[nextPhotoIndex], imageView: nextPhotoImageView)
        
        if photos.count > 1 {
            panGesture = UIPanGestureRecognizer (target: self, action: #selector(onPan(_:)))
        self.view.addGestureRecognizer(panGesture)
        }
        self.title = "\(index + 1) из \(photos.count)"
    }
    
    func configurePhotos(with: Photos, imageView: UIImageView) {
        let url = URL(string: with.url)
        imageView.kf.setImage(with: url)
    }
    
    @objc private func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .changed:
            let translation = recognizer.translation(in: self.view)

            if translation.x > 0 {
                currentPanGestureDirection = .right
            } else if translation.y > 0 {
                    currentPanGestureDirection = .bottom
            } else {
                currentPanGestureDirection = .left
            }
            animatePhotoImageViewChanged(with: translation)
        case .ended:
            animatePhotoImageViewEnd()
        default: return
        }
    }
    
    private func animatePhotoWithTransform(_ transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5) {
            self.currentPhotoImageView.transform = transform
        }
    }
    
    private func animatePhotoImageViewChanged(with translation: CGPoint) {
        if currentPanGestureDirection == .bottom {
            currentPhotoImageView.transform = CGAffineTransform(translationX: 0, y: translation.y)
        } else {
        currentPhotoImageView.transform = CGAffineTransform(translationX: translation.x, y: 0)
        }
    }
    
    private func animatePhotoImageViewEnd() {
        if currentPanGestureDirection == .left {
            
            if currentPhotoImageView.frame.maxX < view.center.x {
                animatePhotoSwap()
            } else {
                animatePhotoWithTransform(transformDefault)
            }
        } else if currentPanGestureDirection == .right {
            if currentPhotoImageView.frame.minX > view.center.x {
                animatePhotoSwap()
            } else {
                animatePhotoWithTransform(transformDefault)
            }
        } else if currentPanGestureDirection == .bottom {
            if currentPhotoImageView.frame.midY > view.center.y + 30 {
                self.navigationController?.popViewController(animated: true)
            } else {
                animatePhotoWithTransform(transformDefault)
            }
        }
    }
    
    private func animatePhotoSwap() {
        configurePhotos(with: photos[nextPhotoIndex], imageView: nextPhotoImageView)
        
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
        currentPhotoImageView.transform = transformReduction
        self.title = "\(index + 1) из \(photos.count)"

        if currentPhotoImageView == firstImageView {
            currentPhotoImageView = secondImageView
            nextPhotoImageView = firstImageView
        } else if currentPhotoImageView == secondImageView {
            currentPhotoImageView = firstImageView
            nextPhotoImageView = secondImageView
        }
    }
    //убираем вьюху с фотками
    @IBAction func popButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //показ tabbara
    private func setupTapBar(hidden:Bool, animated: Bool){
        guard let tabBar = self.tabBarController?.tabBar else { return; }
        if tabBar.isHidden == hidden{ return }
        let alphaCount = hidden ? 0 : 1
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        tabBar.isHidden = false

        UIView.animate(withDuration: duration, animations: {
            tabBar.alpha = CGFloat(alphaCount)
        }, completion: { (true) in
            tabBar.isHidden = hidden
        })
    }
}
