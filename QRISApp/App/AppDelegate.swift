//
//  AppDelegate.swift
//  QRISApp
//
//  Created by Mohammad Azri on 01/04/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navController = UINavigationController()
        navController.navigationBar.isHidden = true
        navController.interactivePopGestureRecognizer?.isEnabled = false
        
        let router = RouterImpl.start()
        let initialVC = router.entry
        
//        navController.pushViewController(initialVC!, animated: false)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = initialVC
        self.window?.overrideUserInterfaceStyle = .light
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

