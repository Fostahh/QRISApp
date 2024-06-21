//
//  AppDelegate.swift
//  QRISApp
//
//  Created by Mohammad Azri on 01/04/24.
//

import UIKit
import FeatureHome

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainConfigurator: MainConfigurator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        mainConfigurator = MainConfigurator(window: self.window ?? UIWindow())
        let navigationController = UINavigationController(rootViewController: mainConfigurator?.createHomeScreen() ?? UIViewController())
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

class MainConfigurator {
    
    private var window: UIWindow?
    
    init(window: UIWindow) {
        initialSetup(window: window)
    }
    
    public func createHomeScreen() -> UIViewController {
        MainNavigation.instance.createHomeScreen()
    }
    
    private func initialSetup(window: UIWindow) {
        self.window = window
        window.overrideUserInterfaceStyle = .light
    }
    
}

class MainNavigation {
    
    private init() {
        HomeConfigurator.shared.delegate = self
    }
    
    public static let instance = MainNavigation()
    
    func createHomeScreen() -> UIViewController {
        return HomeConfigurator.shared.createHomeScene()
    }
}

extension MainNavigation: HomeNavigation {
    
    func fromHomeToScanQRIS(_ viewController: UIViewController) {
        viewController.navigationController?.pushViewController(ScanQRISRouterImpl.createModule(), animated: true)
    }
    
    func fromHomeToHistoryTransaction(_ viewController: UIViewController) {
        viewController.navigationController?.pushViewController(HistoryTransactionsRouterImpl.createModule(), animated: true)
    }
    
}
