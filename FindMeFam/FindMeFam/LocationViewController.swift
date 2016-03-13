//
//  LocationViewController.swift
//  FindMeFam
//
//  Created by Harry Liu on 2016-03-12.
//  Copyright © 2016 HarryLiu. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI

class LocationViewController: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate {
    
    var locationManager: CLLocationManager!
    var currentString = ""
    var homeString = ""
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBAction func buttonPressed(sender: AnyObject) {
        //sendLocation()
        sendText()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLocation()
        getHomeLocation()
        sendLocation()
    }
    
    func initLocation() {
        locationManager = CLLocationManager()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }
    
    func getHomeLocation() {
        homeString = defaults.objectForKey("home") as? String ?? ""
    }
    
    func sendText() {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            print("send me home fam cur: \(currentString) des: \(homeString)")
            controller.body = "send me home fam cur: \(currentString) des: \(homeString)"
            controller.recipients = ["2897960937"]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    /*
    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
            // ...
        }
    }*/
    
    func sendLocation() {
        locationManager.startUpdatingLocation()
        print("working")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        currentString = "\(locValue.latitude) \(locValue.longitude)"
        //label.text = "locations = \(locValue.latitude) \(locValue.longitude)"
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
