//
//  PeopleTableViewController.swift
//  FriendTracker
//
//  Created by Aaron Boswell on 6/5/16.
//  Copyright © 2016 Aaron Boswell. All rights reserved.
//

import UIKit

class PeopleTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var status = "Safe"
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadUI()
        self.navigationController?.navigationBarHidden = false
    }
    
    func reloadUI(){
        let client = FTFriendtrackerClient.defaultClient()
        client.getStateGet().continueWithBlock{ (task:AWSTask) -> AnyObject? in
            if let e = task.error{
                print(e)
            }else{
                if let str = task.result as? String {
                    dispatch_async(dispatch_get_main_queue(), {self.status = str
                    self.tableView.reloadData()})
                }
            }
            return nil
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1000*1000*1000), dispatch_get_main_queue(), {self.reloadUI()})
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if status != "Safe"{
            performSegueWithIdentifier("showMap", sender: self)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("peopleCell", forIndexPath: indexPath)
        cell.textLabel!.text = "Angela"
        cell.detailTextLabel!.text = status
        if status == "Safe"{
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        }else{
            cell.selectionStyle = UITableViewCellSelectionStyle.Blue
        }
        return cell

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
