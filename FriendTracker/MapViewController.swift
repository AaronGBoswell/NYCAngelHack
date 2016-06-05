//
//  MapViewController.swift
//  FriendTracker
//
//  Created by Aaron Boswell on 6/4/16.
//  Copyright © 2016 Aaron Boswell. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var touchView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var annotation:MKPointAnnotation?
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: false)
        
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.spotTapped(_:)))
        gestureRecognizer.numberOfTouchesRequired = 1
        touchView.addGestureRecognizer(gestureRecognizer)
        
        reloadUI()

       // var pin = MK
    }

    func addPinAtLocation(loc:CLLocationCoordinate2D){
        let n = annotation
        
        annotation = MKPointAnnotation()
        annotation!.coordinate = loc
        annotation!.title = "Angela's Location"
        mapView.addAnnotation(annotation!)
        if let note = n{
            mapView.removeAnnotation(note)
        }
    }
    func spotTapped(gestureRecognizer:UITapGestureRecognizer){
        print("Tapped")
        //addPinAtLocation(mapView.userLocation.coordinate)
    
    }
    func reloadUI(){
        let client = FTFriendtrackerClient.defaultClient()
        client.getLocationGet().continueWithBlock { (task:AWSTask) -> AnyObject? in
            if let e = task.error{
                print(e)
            }else{
                if let arr = task.result as? [String] {
                    let loc = CLLocationCoordinate2D.init(latitude: Double(arr[0])!, longitude: Double(arr[1])!)
                    dispatch_async(dispatch_get_main_queue(), {self.addPinAtLocation(loc)})
                }
            }
            return nil
        }
        client.getStateGet().continueWithBlock{ (task:AWSTask) -> AnyObject? in
            if let e = task.error{
                print(e)
            }else{
                if let str = task.result as? String {
                    dispatch_async(dispatch_get_main_queue(), {self.messageLabel.text = "Angela is \(str.lowercaseString == "danger" ? "in danger" : str.lowercaseString)"})
                }
            }
            return nil
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1000*1000*1000), dispatch_get_main_queue(), {self.reloadUI()})

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
