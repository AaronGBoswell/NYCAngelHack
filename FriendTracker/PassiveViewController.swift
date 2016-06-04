//
//  PassiveViewController.swift
//  FriendTracker
//
//  Created by Aaron Boswell on 6/4/16.
//  Copyright © 2016 Aaron Boswell. All rights reserved.
//

import UIKit

class PassiveViewController: UIViewController {
    
    var expiryDate:NSDate! = nil

    @IBOutlet weak var respondLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        expiryDate = NSDate().dateByAddingTimeInterval(60*1)
        refreshUI()
        let notification = UILocalNotification()
        notification.category = "category"
        notification.alertAction = "Are you in immediate danger?"
        notification.fireDate = expiryDate
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.applicationIconBadgeNumber = 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        // Do any additional setup after loading the view.
    }

    func refreshUI(){
        let seconds = Int(expiryDate.timeIntervalSinceNow)
        respondLabel.text = "Please respond:\(seconds/60):\(seconds%60)"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 500), dispatch_get_main_queue(), {self.refreshUI()})
        
        if seconds < 1{
            performSegueWithIdentifier("passiveToDanger", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func inDanger(sender: AnyObject) {
        performSegueWithIdentifier("passiveToDanger", sender: self)
        //TODO notify emergency contact
        //go to danger VC
    }

    @IBAction func toPasscode(sender: AnyObject) {
        performSegueWithIdentifier("passiveToPasscode", sender: sender)

        //TODO go to passcode confirmation
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dvc = segue.destinationViewController as? PasscodeViewController{
            if let button = sender as? UIButton{
                if let text = button.titleLabel?.text{
                    if text == "Extend timer"{
                        dvc.attemptedState = "Unsafe"
                    }else{
                        dvc.attemptedState = "Safe"

                    }

                }
            }
        }
    }
   

}