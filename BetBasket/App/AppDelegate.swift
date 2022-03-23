//
//  AppDelegate.swift
//  BetBasket
//
//  Created by Baran Gungor on 23.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let vc = ListViewController()
        let navVc = UINavigationController(rootViewController: vc)
        window?.rootViewController = navVc
        
        return true
    }

}
