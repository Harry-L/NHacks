//
//  MapViewController.swift
//  FindMeFam
//
//  Created by Harry Liu on 2016-03-12.
//  Copyright © 2016 HarryLiu. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, UISearchBarDelegate {

    @IBAction func showSearchBar(sender: AnyObject) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.barTintColor = UIColor.init(red: 0, green: 102.0/255.0, blue: 153.0/255.0, alpha: 1)
        searchController.searchBar.keyboardAppearance = .Dark
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
    }
    @IBOutlet weak var mapView: MKMapView!
    
    var searchController: UISearchController!
    var annotation: MKAnnotation!
    var localSearchRequest: MKLocalSearchRequest!
    var localSearch: MKLocalSearch!
    var localSearchResponse: MKLocalSearchResponse!
    var pointAnnotation: MKPointAnnotation?
    var pinAnnotationView: MKAnnotationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initColor()
    }
    
    func initColor() {
        navigationController!.navigationBar.barTintColor = UIColor.init(red: 0, green: 102.0/255.0, blue: 153.0/255.0, alpha: 1)
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
        if self.mapView.annotations.count != 0{
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation!.title = searchBar.text
            self.pointAnnotation!.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation!.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let defaults = NSUserDefaults.standardUserDefaults()
        //print(pointAnnotation.coordinate.latitude)
        //print(pointAnnotation.coordinate.longitude)
        if let PA = pointAnnotation {
            defaults.setObject("\(PA.coordinate.latitude) \(PA.coordinate.longitude)", forKey: "home")
        }
    }


}
