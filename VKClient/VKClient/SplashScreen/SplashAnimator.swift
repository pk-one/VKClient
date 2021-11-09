//
//  SplashAnimator.swift
//  VKClient
//
//  Created by Pavel Olegovich on 09.11.2021.
//

import UIKit

protocol SplashAnimatorDescription {
    func animateAppearance()
    func animateDisappearance(completion: (() -> Void)?)
}

class SplashAnimator: SplashAnimatorDescription {
    
    private unowned let backgroundSplashWindow: UIWindow
    private unowned let backgroundSplashViewController: SplashViewController
    
    private unowned let foregroundSplashWindow: UIWindow
    private unowned let foregroundSplashViewController: SplashViewController
    
    init(foregroundSplashWindow: UIWindow, backgroundSplashWindow: UIWindow) {
        self.foregroundSplashWindow = foregroundSplashWindow
        self.backgroundSplashWindow = backgroundSplashWindow
        
        guard let foregroundSplashViewController = foregroundSplashWindow.rootViewController as? SplashViewController,
              let backgroundSplashViewController = backgroundSplashWindow.rootViewController as? SplashViewController
        else { fatalError("Splash window does not have root view controller ") }
        
        self.foregroundSplashViewController = foregroundSplashViewController
        self.backgroundSplashViewController = backgroundSplashViewController
    }
    
    func animateAppearance() {
        foregroundSplashWindow.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.foregroundSplashViewController.logoImageView.transform = CGAffineTransform(scaleX: 136 / 120, y: 136 / 120)
        }
    }
    
    func animateDisappearance(completion: (() -> Void)?) {
        guard let window = UIApplication.shared.delegate?.window, let mainWindow = window, let logoImage = SplashViewController.logoImage else
        { fatalError("App Delegage does not have a windown" ) }
        
        foregroundSplashWindow.alpha = 0
        backgroundSplashWindow.isHidden = false
        
        let mask = CALayer()
        mask.frame = self.foregroundSplashViewController.logoImageView.frame
        mask.contents = logoImage.cgImage
        mainWindow.layer.mask = mask
        
        let maskImageView = UIImageView(image: logoImage)
        maskImageView.frame = mask.frame
        mainWindow.addSubview(maskImageView)
        mainWindow.bringSubviewToFront(maskImageView)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }
        
        mainWindow.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.6) {
            mainWindow.transform = .identity
        }
        
        [mask, maskImageView.layer].forEach {
            addRotationAnimation(to: $0, duration: 0.6)
            addScalingAnimation(to: $0, duration: 0.6)
        }
        
        UIView.animate(withDuration: 0.15, delay: 0.15, options: []) {
            maskImageView.alpha = 0
        } completion: { _ in
            maskImageView.removeFromSuperview()
        }
        CATransaction.commit()
    }
    
    private func addRotationAnimation(to layer: CALayer, duration: TimeInterval) {
        let animation = CABasicAnimation()
        let tangent = layer.position.y / layer.position.x
        let angle = atan(tangent)
        
        animation.beginTime = CACurrentMediaTime()
        animation.duration = duration
        animation.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateZ)
        animation.fromValue = 0
        animation.toValue = angle
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        
        layer.add(animation, forKey: "transform")
    }
    
    private func addScalingAnimation(to layer: CALayer, duration: TimeInterval) {
        let animation = CAKeyframeAnimation(keyPath: "bounds")
        let width = layer.frame.width
        let height = layer.frame.height
        let coef: CGFloat = 18 / 667
        let finalScale = coef * UIScreen.main.bounds.height
        let scales: [CGFloat] = [1, 0.85, finalScale]
        
        animation.beginTime = CACurrentMediaTime()
        animation.duration = duration
        animation.values = scales.map { NSValue(cgRect: CGRect(x: 0, y: 0, width: width * $0, height: height * $0 )) }
        animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),
                                     CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        
        layer.add(animation, forKey: "bounds")
    }
}
