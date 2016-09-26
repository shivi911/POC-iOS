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

    func startScanning() {
        print("SCANNING ...");
        // locationManager.startUpdatingLocation()
        
        let uuid = NSUUID(UUIDString: "8DEEFBB9-F738-4297-8040-96668BB44281")
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "MyBeacon")
        beaconRegion.notifyOnEntry = true;
        beaconRegion.notifyOnExit = true;
        beaconRegion.notifyEntryStateOnDisplay = true;
        
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.pausesLocationUpdatesAutomatically = false
        // locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    
    func startStandardLocationService() {
        
        locationManager.delegate = self;
        
        locationManager.requestAlwaysAuthorization();
        // locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        // locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        locationManager.distanceFilter = 1;
        locationManager.startUpdatingLocation();
        
        
    }
    
    @IBAction func stopRanging(sender: AnyObject) {
        let monitoredRegions = locationManager.monitoredRegions
        for region in monitoredRegions {
            locationManager.stopMonitoringForRegion(region)
        }
        
        
        
    }
    
    
}

