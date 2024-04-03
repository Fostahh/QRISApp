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
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = HomeRouterImpl.createModule()
        self.window?.overrideUserInterfaceStyle = .light
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

