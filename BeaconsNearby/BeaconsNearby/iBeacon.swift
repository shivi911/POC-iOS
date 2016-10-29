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
        showLocalNotification(body: "setupBeacon")
        
        let uuid = UUID(uuidString: "8DEEFBB9-F738-4297-8040-96668BB44281")
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "MyBeacon")
        beaconRegion.notifyOnEntry = true;
        beaconRegion.notifyOnExit = true;
        beaconRegion.notifyEntryStateOnDisplay = true;
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startUpdatingLocation()
        locationManager.requestState(for: beaconRegion)
        locationManager.pausesLocationUpdatesAutomatically = false
        // locationManager.startRangingBeaconsInRegion(beaconRegion)
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                           didUpdateLocations locations: [CLLocation]) {
        // print("GOT LOC UPDATE \(locations[0].coordinate.latitude) \(locations[0].coordinate.longitude)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        print("STATUS CHANGE")
        switch status {
            
        case .authorizedAlways:
            // Starts the generation of updates that report the user’s current location.
            print("START UPDATE")
            locationManager.startUpdatingLocation()
        default:
            break;
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        showLocalNotification(body: "Started Monitoring")
        
        // locationManager.requestState(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didEnterRegion region: CLRegion) {
        
        print("Entered Region")
        showLocalNotification(body: "Entered Region")
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didExitRegion region: CLRegion) {
        showLocalNotification(body: "Exited region")
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        
        
        if state == CLRegionState.inside { //The user is inside the iBeacon range.
            showLocalNotification(body: "Inside")
            // locationManager.startMonitoring(for: region as! CLBeaconRegion)
            // showLocalNotification(body: "Did DetermineState: Start Ranging")
            // locationManager.startRangingBeacons(in: region as! CLBeaconRegion)
        }
        else { //The user is outside the iBeacon range.
            showLocalNotification(body: "Outside")
            // locationManager.stopRangingBeacons(in: region as! CLBeaconRegion)
        }
        locationManager.startMonitoring(for: region as! CLBeaconRegion)
        locationManager.startRangingBeacons(in: region as! CLBeaconRegion)
        // showLocalNotification(body: "Outside")
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        for beacon in beacons {
            showBeaconInfo(beacon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        showLocalNotification(body: "StartRangingFailed + \(error.localizedDescription)")
        
    }
    
    func showBeaconInfo(_ beacon: CLBeacon) {
        let notification = UILocalNotification()
        notification.alertBody = "Unknown State"
        notification.alertAction = "open"
        // UIApplication.sharedApplication().scheduledLocalNotifications?.count;
        if(foundBeacons.count > 0) {
            notification.applicationIconBadgeNumber = foundBeacons.count;
        }
        
        
        switch beacon.proximity {
        case .unknown:
            self.view.backgroundColor = UIColor.gray
            showLocalNotification(body: "Unknown \(beacon.major): \(beacon.minor)")
            
        case .far:
            self.view.backgroundColor = UIColor.blue
            showLocalNotification(body: "Far \(beacon.major): \(beacon.minor)")
            
            // if(foundBeacons[body] == nil) { // show notification if not shown earlier
               //  UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            // }
            
            // foundBeacons.updateValue(body, forKey: body)
            
        case .near:
            self.view.backgroundColor = UIColor.orange
            showLocalNotification(body: "Near \(beacon.major): \(beacon.minor)")
            
        case .immediate:
            self.view.backgroundColor = UIColor.red
            showLocalNotification(body: "Immedidate \(beacon.major): \(beacon.minor)")
            
        }
        /*
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
 */
    }
    
    func showLocalNotification(body: String) {
        let notification = UILocalNotification()
        notification.alertBody = body
        notification.alertAction = "open"
        UIApplication.shared.presentLocalNotificationNow(notification)
    }

}
