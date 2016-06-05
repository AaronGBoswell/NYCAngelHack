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

    @IBOutlet weak var touchView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var annotation:MKPointAnnotation?
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: false)
        
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.spotTapped(_:)))
        gestureRecognizer.numberOfTouchesRequired = 1
        touchView.addGestureRecognizer(gestureRecognizer)
        
       // var pin = MK
    }

    func addPinAtLocation(loc:CLLocationCoordinate2D){
        if let note = annotation{
            mapView.removeAnnotation(note)
        }
        
        annotation = MKPointAnnotation()
        annotation!.coordinate = loc
        annotation!.title = "Angela's Location"
        mapView.addAnnotation(annotation!)
    }
    func spotTapped(gestureRecognizer:UITapGestureRecognizer){
        print("Tapped")
        addPinAtLocation(mapView.userLocation.coordinate)
    
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
