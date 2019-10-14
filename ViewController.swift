//
//  ViewController.swift
//  where i am
//
//  Created by Student P_08 on 16/09/19.
//  Copyright © 2019 yashwant. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
let locationmanager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func changemaptype(_ sender: UISegmentedControl) {
        switch segment.selectedSegmentIndex{
        case 0:mapview.mapType = .standard
        case 1:mapview.mapType = .satellite
        case 2:mapview.mapType = .hybrid
            
        default:
            mapview.mapType = .standard
        }
        
        }
    @IBOutlet weak var mapview: MKMapView!
    @IBAction func detectlocation(_ sender: UIButton) {
        detectlocation()
    }
 func detectlocation()
 {
    locationmanager.desiredAccuracy = kCLLocationAccuracyBest
    locationmanager.delegate = self
    locationmanager.requestWhenInUseAuthorization()
    locationmanager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentlocation = locations.last!
        let latitude = currentlocation.coordinate.latitude
        let longitude = currentlocation.coordinate.longitude
        ("latitude = \(latitude) and longitude = \(longitude)")
        let span = MKCoordinateSpanMake(0.01, 0.
        let region = MKCoordinateRegionMake(currentlocation.coordinate, span)
        mapview.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentlocation.coordinate
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentlocation){(placemarks,error)in
            let placemark:CLPlacemark = (placemarks?.first)!
            let country = placemark.country
            annotation.title = country
            self.mapview.addAnnotation(annotation)
        }  }
    
    @IBOutlet weak var segment: UISegmentedControl!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

