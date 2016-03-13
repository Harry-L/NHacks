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
    var phone = ""
    
    @IBAction func buttonPressed(sender: AnyObject) {
        //sendLocation()
        sendText()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLooks()
        initLocation()
        getHomeLocation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        sendLocation()
    }
    
    func initLooks() {
        navigationController!.navigationBar.barTintColor = UIColor.blackColor()
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()

        let layer = CAGradientLayer()
        layer.frame = view.frame
        layer.colors = [UIColor.init(red: 0, green: 102.0/255.0, blue: 153.0/255.0, alpha: 1).CGColor, UIColor.init(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1).CGColor]
        layer.zPosition = -1
        view.layer.addSublayer(layer)
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
    
    func getPhone() {
        phone = defaults.objectForKey("phone") as? String ?? ""
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
    
    func findMyFam() {
        getPhone()
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            print("find my fam \(phone) cur: \(currentString)")
            controller.body = "find my fam \(phone) cur: \(currentString)"
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
        //print("working")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        currentString = "\(locValue.latitude) \(locValue.longitude)"
        manager.stopUpdatingLocation()
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
