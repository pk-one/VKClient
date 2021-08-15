//
//  SurveyFriendsPhotoViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 14.08.2021.
//

import UIKit

class SurveyFriendsPhotoViewController: UIViewController {
    
    @IBOutlet var surveyImageView: UIImageView!
    
    var photos: [String]!
    var index = 0
    
    var swipeToRight: UIViewPropertyAnimator!
    var swipeToLeft: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        surveyImageView.image = UIImage(named: photos[index])
        let gestPan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        view.addGestureRecognizer(gestPan)
        self.title = "\(index + 1) из \(photos.count)"
    }
    
    private func startAnimate(){
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            self.surveyImageView.transform = .identity
        })
    }
    
    @objc private func onPan(_ recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
        case .began:
            swipeToRight = UIViewPropertyAnimator(
                duration: 0.5,
                curve: .easeInOut,
                animations: {
                    UIView.animate(
                        withDuration: 0.01,
                        delay: 0,
                        options: [],
                        animations: {
                            let scale = CGAffineTransform(scaleX: 0.6, y: 0.6)
                            self.surveyImageView.transform = scale
                        }, completion: { [self] _ in
                            let translation = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
                            self.surveyImageView.transform = translation
                            self.index -= 1
                            if self.index < 0 {
                                self.index = self.photos.count - 1
                            }
                            self.startAnimate()
                            surveyImageView.image = UIImage(named: photos[index])
                            self.title = "\(index + 1) из \(photos.count)"
                        })
                })
            
            swipeToLeft = UIViewPropertyAnimator(
                duration: 0.5,
                curve: .easeInOut,
                animations: {
                    UIView.animate(
                        withDuration: 0.01,
                        delay: 0,
                        options: [],
                        animations: {
                            let scale = CGAffineTransform(scaleX: 0.6, y: 0.6)
                            self.surveyImageView.transform = scale
                        }, completion: { [self] _ in
                            let translation = CGAffineTransform(translationX: -self.view.bounds.width, y: 0)
                            self.surveyImageView.transform = translation
                            self.index += 1
                            if self.index > self.photos.count - 1 {
                                self.index = 0
                            }
                            self.startAnimate()
                            surveyImageView?.image = UIImage(named: self.photos[self.index])
                            self.title = "\(index + 1) из \(photos.count)"
                        })
                })
            
        case .changed:
            let translationX = recognizer.translation(in: self.view).x
            if translationX > 0 {
                swipeToRight.fractionComplete = abs(translationX) / 100
            } else {
                swipeToLeft.fractionComplete = abs(translationX) / 100
            }
            
        case .ended:
       swipeToRight.continueAnimation(withTimingParameters: nil, durationFactor: 0)
       swipeToLeft.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            return
        }
    }
}
