//
//  AppDelegate.swift
//  Shopping App
//
//  Created by Berkay YAY on 27.10.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupFirebase()
        setupWindow()
        return true
    }
    
    
    private func setupFirebase() {
        FirebaseApp.configure()
        
        _ = Firestore.firestore()
    }
    
    private func setupWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = OnboardingViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    


}

