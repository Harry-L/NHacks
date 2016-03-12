//
//  SecondViewController.swift
//  531
//
//  Created by Harry Liu on 2016-01-20.
//  Copyright © 2016 HarryLiu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBAction func toggleMenu(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

