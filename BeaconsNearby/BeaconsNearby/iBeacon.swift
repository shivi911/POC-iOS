//
//  iBeacon.swift
//  BeaconsNearby
//
//  Created by Shivi on 8/21/16.
//  Copyright © 2016 NaviSpin. All rights reserved.
//
import UIKit
import CoreLocation

extension ViewController: CLLocationManagerDelegate {
    
    func setupBeacon() {
        
        locationManager.delegate = self
        
        let uuid = NSUUID(UUIDString: "8DEEFBB9-F738-4297-8040-96668BB44281")
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "MyBeacon")
        beaconRegion.notifyOnEntry = true;
        beaconRegion.notifyOnExit = true;
        beaconRegion.notifyEntryStateOnDisplay = true;
        
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.pausesLocationUpdatesAutomatically = false
        // locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    func locationManager(manager: CLLocationManager,
                           didUpdateLocations locations: [CLLocation]) {
        // print("GOT LOC UPDATE \(locations[0].coordinate.latitude) \(locations[0].coordinate.longitude)")
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        print("STATUS CHANGE")
        switch status {
            
        case .AuthorizedAlways:
            // Starts the generation of updates that report the user’s current location.
            print("START UPDATE")
            manager.startUpdatingLocation()
        default:
            break;
            
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        print("Started monitoring")
        
        // manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
        
        locationManager.requestStateForRegion(region)
    }
    
    func locationManager(manager: CLLocationManager,
                         didEnterRegion region: CLRegion) {
        
        print("Entered Region")
        // let notification = UILocalNotification()
        
        // notification.alertBody = "Entered region"
        // notification.alertAction = "open"
        
    }
    
    func locationManager(manager: CLLocationManager,
                         didExitRegion region: CLRegion) {
        let notification = UILocalNotification()
        
        notification.alertBody = "Exited region"
        notification.alertAction = "open"
        
    }
    
    func locationManager(manager: CLLocationManager,
                         didDetermineState state: CLRegionState,
                                           for region: CLRegion) {
        
        print("DETERMINE STATE")
        
        switch  state {
            
        case .Inside:
            //The user is inside the iBeacon range.
            
            manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
            
            break
            
        case .Outside:
            //The user is outside the iBeacon range.
            
            locationManager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
            
            break
            
        default :
            // it is unknown whether the user is inside or outside of the iBeacon range.
            break
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        
        if beacons.count > 0 {
            
            let beacon = beacons[0]
            print("MAJOR  \(beacon.major) MINOR \(beacon.minor)")
            updateDistance(beacon.proximity)
        } else {
            updateDistance(.Unknown)
        }
    }
    
    func updateDistance(distance: CLProximity) {
        UIView.animateWithDuration(0.8) {
            switch distance {
            case .Unknown:
                self.view.backgroundColor = UIColor.grayColor()
                
            case .Far:
                self.view.backgroundColor = UIColor.blueColor()
                
            case .Near:
                self.view.backgroundColor = UIColor.orangeColor()
                
            case .Immediate:
                self.view.backgroundColor = UIColor.redColor()
            }
        }
    }

}
