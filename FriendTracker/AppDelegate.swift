//
//  AppDelegate.swift
//  FriendTracker
//
//  Created by Aaron Boswell on 6/4/16.
//  Copyright © 2016 Aaron Boswell. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager:CLLocationManager! = nil

    var topView:UIViewController{
        get{
            var topView:UIViewController! = UIApplication.sharedApplication().keyWindow?.rootViewController
            while let view = topView?.presentedViewController{
                topView = view
            }
            return topView
        }
    }
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let yesAction = UIMutableUserNotificationAction()
        yesAction.identifier = "yesAction"
        yesAction.title = "Yes"
        yesAction.activationMode = UIUserNotificationActivationMode.Background
        yesAction.destructive = true
        yesAction.authenticationRequired = false
        
        let noAction = UIMutableUserNotificationAction()
        noAction.identifier = "noAction"
        noAction.title = "No"
        noAction.activationMode = UIUserNotificationActivationMode.Foreground
        noAction.destructive = false
        noAction.authenticationRequired = false
        
        let category = UIMutableUserNotificationCategory()
        category.identifier = "category"
        category.setActions([yesAction,noAction], forContext:UIUserNotificationActionContext.Default)
        
        
        
        var type = UIUserNotificationType.Alert
        type = type.union(UIUserNotificationType.Badge)
        type = type.union(UIUserNotificationType.Sound)
        type = type.union(UIUserNotificationType.Alert)
        let settings = UIUserNotificationSettings(forTypes: type, categories: [category])
        
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        setupLocation()
        print("setup done")
        // Override point for customization after application launch.
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print(deviceToken)
    }
    func setupLocation(){
        print(CLLocationManager.authorizationStatus())
        print(CLLocationManager.locationServicesEnabled())
        if locationManager == nil{
            locationManager = CLLocationManager()
            
        }
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 200
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location update")
        if let location = locations.last{
            let date = location.timestamp
            let howRecent = date.timeIntervalSinceNow
            if abs(howRecent) < 15.0{
                print(location.coordinate.latitude)
                print(location.coordinate.longitude)
                let client = FTFriendtrackerClient.defaultClient()
                let locInfo = FTUpdateLocationModel_info()
                locInfo.lat = "\(location.coordinate.latitude)"
                locInfo.lon = "\(location.coordinate.longitude)"

                let locModel = FTUpdateLocationModel()
                locModel.userId = "a"
                locModel.info = locInfo
                client.updateLocationPut(locModel).continueWithBlock { (task:AWSTask) -> AnyObject? in
                    if let e = task.error{
                        print(e)
                    }else{
                        //print(task.result! as! String)
                    }
                    return nil
                }
                //TODO update Location
            }
        }
        
    }
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        if let ident = identifier{
            if ident == "yesAction" {
                //Send Danger Status
                
                let notification = UILocalNotification()
                notification.alertAction = "Thanks"
                notification.alertTitle = "We have alerted your Emergency Contatct"
                notification.alertBody = "We have alerted your Emergency Contatct"
                notification.fireDate = NSDate()
                notification.timeZone = NSTimeZone.defaultTimeZone()
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.applicationIconBadgeNumber = 1
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("DangerViewController") as! DangerViewController
                vc.reason = "danger"
                topView.presentViewController(vc, animated: true, completion: nil)
                
                
                
            } else if ident == "noAction" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("PasscodeViewController") as! PasscodeViewController
                vc.attemptedState = "Unsafe"
                topView.presentViewController(vc, animated: true, completion: nil)

                //TODO go to passcode with Unsafe
            }
        }
        completionHandler()
    }
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        if (launchOptions?[UIApplicationLaunchOptionsLocalNotificationKey] as? UILocalNotification) != nil{
            print("here")
        }
        UIApplication.sharedApplication().applicationIconBadgeNumber = -1
        application.applicationIconBadgeNumber = -1

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

