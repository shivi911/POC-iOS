//
//  ViewController.swift
//  BeaconsNearby
//
//  Created by Shivi on 8/21/16.
//  Copyright © 2016 NaviSpin. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    var locationManager = CLLocationManager()
    
    var foundBeacons = Dictionary<String, String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // locationManager = CLLocationManager()
        locationManager.delegate = self;
        
        // locationManager.requestAlwaysAuthorization();
        // locationManager.startUpdatingLocation();
        
        startStandardLocationService();
        
        self.setupBeacon()
        /*
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
*/
        
        // startScanning()
        
        /*
        if CLLocationManager.isRangingAvailable() {
            startScanning()
        }
 */
        /*
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways) {
          
            locationManager.requestAlwaysAuthorization();
            print("HI")
            if CLLocationManager.isRangingAvailable() {
                startScanning()
            }
        }
 */
     
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func startStandardLocationService() {
        
        locationManager.delegate = self;
        
        locationManager.requestAlwaysAuthorization();
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        // locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        // locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        locationManager.distanceFilter = 1;
        locationManager.startUpdatingLocation();
        
        
    }
    
    @IBAction func stopRanging(_ sender: AnyObject) {
        let monitoredRegions = locationManager.monitoredRegions
        for region in monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
        
        
        
    }
    
    
}

