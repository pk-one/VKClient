//
//  SplashPresenter.swift
//  VKClient
//
//  Created by Pavel Olegovich on 09.11.2021.
//

import UIKit

protocol SplashPresenterDescription {
    func present()
    func dismiss(completion: (() -> Void)?)
}

final class SplashPresenter: SplashPresenterDescription {
    
    
    private lazy var animator: SplashAnimatorDescription = SplashAnimator(foregroundSplashWindow: foregroundSplashWindow, backgroundSplashWindow: backgroundSplashWindow)
    
    private lazy var foregroundSplashWindow: UIWindow = {
        let splashViewController = self.splashViewController(logoIsHidden: false)
        return splashWindow(level: .normal + 1, rootViewController: splashViewController)
    }()
    
    private lazy var backgroundSplashWindow: UIWindow = {
        let splashViewController = self.splashViewController(logoIsHidden: true)
        return splashWindow(level: .normal - 1, rootViewController: splashViewController)
    }()
    
    
    private func splashViewController(logoIsHidden: Bool) -> SplashViewController? {
        let splashViewController = SplashViewController()
        splashViewController.logoIsHidden = logoIsHidden
        return splashViewController
    }
    
    private func splashWindow(level: UIWindow.Level, rootViewController: SplashViewController?) -> UIWindow {
        let splashWindow = UIWindow()
        splashWindow.windowLevel = level
        splashWindow.rootViewController = rootViewController
        return splashWindow
    }
    
    func present() {
        animator.animateAppearance()
    }
     
    func dismiss(completion: (() -> Void)?) {
        animator.animateDisappearance(completion: completion)
    }
}
