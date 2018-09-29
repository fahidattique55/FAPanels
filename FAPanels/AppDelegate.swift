//
//  AppDelegate.swift
//  FAPanels
//
//  Created by Fahid Attique on 10/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.sharedManager().enable = true
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let leftMenuVC: LeftMenuVC = mainStoryboard.instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuVC
        let rightMenuVC: RightMenuVC = mainStoryboard.instantiateViewController(withIdentifier: "RightMenuVC") as! RightMenuVC
        let centerVC: CenterVC = mainStoryboard.instantiateViewController(withIdentifier: "CenterVC1") as! CenterVC
        let centerNavVC = UINavigationController(rootViewController: centerVC)
  
        
        /*

         //  Case 1: With Code only approah
         let rootController = FAPanelController()

        */


        //  Case 2: With Xtoryboards, Xibs And NSCoder
        let rootController: FAPanelController = window?.rootViewController as! FAPanelController

        rootController.configs.rightPanelWidth = 80
        rootController.configs.bounceOnRightPanelOpen = false
        
        _ = rootController.center(centerNavVC).left(leftMenuVC).right(rightMenuVC)

        /*
         _ = rootController.center(centerNavVC).letf(leftMenuVC)
         _ = rootController.center(centerNavVC).right(rightMenuVC)
         rootController.leftPanelPosition = .front
         rootController.rightPanelPosition = .front
         */


        //  For Case 1 only
        window?.rootViewController = rootController
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

