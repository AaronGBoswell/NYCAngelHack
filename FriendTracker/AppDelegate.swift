//
//  AppDelegate.swift
//  FriendTracker
//
//  Created by Aaron Boswell on 6/4/16.
//  Copyright © 2016 Aaron Boswell. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let yesAction = UIMutableUserNotificationAction()
        yesAction.identifier = "yesAction"
        yesAction.title = "Yes"
        yesAction.activationMode = UIUserNotificationActivationMode.Background
        yesAction.destructive = true
        yesAction.authenticationRequired = false
        
        let noAction = UIMutableUserNotificationAction()
        noAction.identifier = "noAction"
        noAction.title = "no"
        noAction.activationMode = UIUserNotificationActivationMode.Foreground
        noAction.destructive = false
        noAction.authenticationRequired = false
        
        let category = UIMutableUserNotificationCategory()
        category.identifier = "category"
        category.setActions([yesAction,noAction], forContext:UIUserNotificationActionContext.Default)
        
        
        
        var type = UIUserNotificationType.Alert
        type = type.union(UIUserNotificationType.Badge)
        type = type.union(UIUserNotificationType.Sound)
        let settings = UIUserNotificationSettings(forTypes: type, categories: [category])
        
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        print("setup done")
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

