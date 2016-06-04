//
//  PasscodeViewController.swift
//  FriendTracker
//
//  Created by Aaron Boswell on 6/4/16.
//  Copyright © 2016 Aaron Boswell. All rights reserved.
//

import UIKit

class PasscodeViewController: UIViewController {
    
    @IBOutlet weak var explainLabel: UILabel!
    
    var state:String?
    var attemptedState:String?
    @IBOutlet weak var messageLabel: UILabel!
    var passcode = "1234"
    var enteredPasscode = ""
    @IBAction func digetTapped(sender: UIButton) {
        messageLabel.text = messageLabel.text!.stringByAppendingString("*")
        enteredPasscode.appendContentsOf(sender.titleLabel!.text!)
        if enteredPasscode == passcode{
            passcodeEntered()
        }
    }
    @IBAction func deleteDigit(sender: AnyObject) {
        enteredPasscode.removeAtIndex(enteredPasscode.endIndex.predecessor())
    }
    
    func passcodeEntered(){
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        if attemptedState == "Safe"{
            performSegueWithIdentifier("passcodeToStart", sender: self)
        }
        if attemptedState == "Unsafe"{
            performSegueWithIdentifier("passcodeToUnsafe", sender: self)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = ""
        if (attemptedState == nil){
            attemptedState = "Safe"
        }else{
            if attemptedState! == "Unsafe"{
                explainLabel.text = "Please enter your passcode to extend the timer"
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
