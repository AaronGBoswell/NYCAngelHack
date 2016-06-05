//
//  ViewController.swift
//  FriendTracker
//
//  Created by Aaron Boswell on 6/4/16.
//  Copyright © 2016 Aaron Boswell. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let client = FTFriendtrackerClient.defaultClient()
        let data = FTUserUpdateModel()
        data.userId = "a"
        data.stat = "Safe"
        client.updateStatePut(data)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func unsafeButton(sender: AnyObject) {
        
        //TODO notify EC
        //Schedule a notification
        
        self.performSegueWithIdentifier("unsafeSegue", sender: self)
    }


}

