//
//  AppDelegate.swift
//  Chat
//
//  Created by Dmitry Bakulin on 22.09.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //start

    var previousState =  UIApplication.shared.applicationState
    var currentState =  UIApplication.shared.applicationState
    
    
    func logStateAndMethod(methodName: String = #function){
        var prevState: String
        var curState: String
        
        currentState =  UIApplication.shared.applicationState
        
        switch previousState {
        case .active:
            prevState = "active"
        case .inactive:
            prevState = "inactive"
        case .background:
            prevState = "background"
            
        }
        
        switch currentState {
        case .active:
            curState = "active"
        case .inactive:
            curState = "inactive"
        case .background:
            curState = "background"
            
        }
        
        print("Application moved from <\(prevState)> to <\(curState)>: <\(methodName)>")
        
        previousState = currentState
    }
    
    //end

    
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        logStateAndMethod()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        logStateAndMethod()
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        logStateAndMethod()
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        logStateAndMethod()
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        logStateAndMethod()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        logStateAndMethod()
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

