//
//  AppDelegate.swift
//  VKClient
//
//  Created by Pavel Olegovich on 16.07.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var splashPresenter: SplashPresenterDescription? = SplashPresenter()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        splashPresenter?.present()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.splashPresenter?.dismiss(completion: {
                self?.splashPresenter = nil
            })
        }
        
        FirebaseApp.configure()
        return true
    }
}

