//
//  AppDelegate.swift
//  BetBasket
//
//  Created by Baran Gungor on 23.03.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let vc = ListViewController()
        let navVc = UINavigationController(rootViewController: vc)
        window?.rootViewController = navVc
        
        initFirebase()
        initAnalytics()
        
        return true
    }
    
    func initFirebase() {
        FirebaseApp.configure()
    }
    
    func initAnalytics() {
        // AnalyticsManager supports multiple providers.
        // A protocol-oriented approach was applied.
        AnalyticsManager.shared.initialize([FirebaseAnalyticsProvider()])
    }

}

//Removed because SDWebImage library is not used.
