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
    let defaults = NSUserDefaults.standardUserDefaults()
    var phone = ""

    @IBOutlet weak var textField: UITextField!
    @IBAction func textChanged(sender: AnyObject) {
        let phone = textField.text
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(phone, forKey: "phone")
    }
    @IBOutlet weak var textField2: UITextField!
    @IBAction func bringMyFam(sender: AnyObject) {
    }
    @IBAction func text2Changed(sender: AnyObject) {
        phone = "+1\(textField2.text)"
        sendMyLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendLocation()
    }
    
    func sendMyLocation() {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "bring my fam \(phone) \(currentString)"
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
