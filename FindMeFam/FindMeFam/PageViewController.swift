//
//  PageViewController.swift
//  FindMeFam
//
//  Created by Harry Liu on 2016-03-12.
//  Copyright © 2016 HarryLiu. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var views = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        initViewControllers()
        initFirstController()
        initColors()
        
        self.navigationController!.interactivePopGestureRecognizer!.enabled = false
    }
    
    func initColors() {
        let layer = CAGradientLayer()
        layer.frame = view.frame
        layer.colors = [UIColor.init(red: 0, green: 102.0/255.0, blue: 153.0/255.0, alpha: 1).CGColor, UIColor.init(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1).CGColor]
        layer.zPosition = -1
        view.layer.addSublayer(layer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initFirstController() {
        if let firstViewController = views.first {
            setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func initViewControllers() {
        for i in 1 ... 2 {
            views.append(newViewController(i))
        }
    }
    
    func newViewController(n: Int) -> UIViewController {
        var s = "";
        switch n {
        case 1:
            s = "First"
        case 2:
            s = "Second"
        default:
            s = "First"
        }
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewControllerWithIdentifier("\(s)ViewController")
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = views.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard views.count > previousIndex else {
            return nil
        }
        
        return views[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = views.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = views.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return views[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return views.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            firstViewControllerIndex = views.indexOf(firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    override func viewDidLayoutSubviews() {
        //corrects scrollview frame to allow for full-screen view controller pages
        for subView in self.view.subviews {
            if subView is UIScrollView {
                subView.frame = self.view.bounds
            }
        }
        super.viewDidLayoutSubviews()
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
