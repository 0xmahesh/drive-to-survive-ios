//
//  AppDelegate.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 2/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let splashVC = SplashScreenViewController(nibName: "SplashScreenViewController", bundle: nil)
        let navigationController = UINavigationController.init(rootViewController: splashVC)
                
        self.window!.rootViewController = splashVC
        self.window!.makeKeyAndVisible()
        
        for family in UIFont.familyNames {

            let sName: String = family as String
            print("family: \(sName)")
                    
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
        
        return true
    }



}

