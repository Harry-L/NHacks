//
//  FindMyFamViewController.swift
//  FindMeFam
//
//  Created by Harry Liu on 2016-03-13.
//  Copyright © 2016 HarryLiu. All rights reserved.
//

import UIKit
import MessageUI
import CoreLocation

class FindMyFamViewController: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate {
    
    var locationManager: CLLocationManager!
    var currentString = ""
    var homeString = ""
    let defaults = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var textField: UITextField!
    @IBAction func textChanged(sender: AnyObject) {
        let phone = textField.text
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(phone, forKey: "phone")
        
    }
    @IBAction func bringMyFam(sender: AnyObject) {
        
    }
    
    func sendText() {
        print("working")
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
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
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
    
    
    
}
