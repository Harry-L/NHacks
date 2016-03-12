//
//  ContainerViewController.swift
//  531
//
//  Created by Harry Liu on 2016-01-20.
//  Copyright © 2016 HarryLiu. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    let leftMenuWidth: CGFloat = 260

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dispatch_async(dispatch_get_main_queue()) {
            self.closeMenu(false)
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "toggleMenu", name: "toggleMenu", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "closeMenuViaNotification", name: "closeMenuViaNotificatino", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openModalWindow", name: "openModalWindow", object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func openModalWindow() {
        performSegueWithIdentifier("openModalWindow", sender: nil)
    }
    
    func toggleMenu() {
        scrollView.contentOffset.x == 0 ? closeMenu() : openMenu()
    }
    
    func closeMenuViaNotification() {
        closeMenu()
    }
    
    func closeMenu(animated:Bool = true) {
        scrollView.setContentOffset(CGPoint(x: leftMenuWidth, y: 0), animated: animated)
    }
    
    func openMenu() {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
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

extension ContainerViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("scrollView.contentOffset.x:: \(scrollView.contentOffset.x)")
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollView.pagingEnabled = true
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollView.pagingEnabled = false
    }
}
