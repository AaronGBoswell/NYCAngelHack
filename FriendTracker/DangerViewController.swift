//
//  DangerViewController.swift
//  FriendTracker
//
//  Created by Aaron Boswell on 6/4/16.
//  Copyright © 2016 Aaron Boswell. All rights reserved.
//

import UIKit

class DangerViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!

    var reason = "time"
    override func viewDidLoad() {
        super.viewDidLoad()
        if reason != "time"{
            messageLabel.text = "Your emergency contact has been notified of your dagner"
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
