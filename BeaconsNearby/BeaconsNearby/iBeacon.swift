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
        locationManager.startUpdatingLocation()
        locationManager.requestStateForRegion(beaconRegion)
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
            locationManager.startUpdatingLocation()
        default:
            break;
            
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        print("Started monitoring")
        let notification = UILocalNotification()
        notification.alertBody = "Started Monitoring"
        notification.alertAction = "open"
        notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.soundName = UILocalNotificationDefaultSoundName
        // UIApplication.sharedApplication().scheduleLocalNotification(notification)
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        
        
        // manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
        
        locationManager.requestStateForRegion(region)
    }
    
    func locationManager(manager: CLLocationManager,
                         didEnterRegion region: CLRegion) {
        
        print("Entered Region")
        
        let notification = UILocalNotification()
        notification.alertBody = "Entered Region"
        notification.alertAction = "open"
        // notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        
        
    }
    
    func locationManager(manager: CLLocationManager,
                         didExitRegion region: CLRegion) {
        let notification = UILocalNotification()
        
        notification.alertBody = "Exited region"
        notification.alertAction = "open"
        notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
        
        let notification = UILocalNotification()
        notification.alertBody = "Stop Ranging"
        notification.alertAction = "open"
        // notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.soundName = UILocalNotificationDefaultSoundName
        // UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        
        if state == CLRegionState.Inside { //The user is inside the iBeacon range.
            notification.alertBody = "Did DetermineState: Start Ranging"
            notification.alertAction = "open"
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            locationManager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
        }
        else { //The user is outside the iBeacon range.
           // UIApplication.sharedApplication().presentLocalNotificationNow(notification)
           // locationManager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
            // TODO: removed beacons from dictionary
        }
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
       // var beacon : CLBeacon
        
        for beacon in beacons {
            showBeaconInfo(beacon)
        }
    }
    
    
    func showBeaconInfo(beacon: CLBeacon) {
        let notification = UILocalNotification()
        notification.alertBody = "Unknown State"
        notification.alertAction = "open"
        // UIApplication.sharedApplication().scheduledLocalNotifications?.count;
        if(foundBeacons.count > 0) {
            notification.applicationIconBadgeNumber = foundBeacons.count;
        }
        
        
        switch beacon.proximity {
        case .Unknown:
            self.view.backgroundColor = UIColor.grayColor()
            notification.alertBody = "Unknown \(beacon.major): \(beacon.minor)"
            // UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            
        case .Far:
            self.view.backgroundColor = UIColor.blueColor()
            let body = "Far \(beacon.major): \(beacon.minor)";
            notification.alertBody = body
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            if(foundBeacons[body] == nil) { // show notification if not shown earlier
               //  UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            }
            
            foundBeacons.updateValue(body, forKey: body)
            
        case .Near:
            self.view.backgroundColor = UIColor.orangeColor()
            let body = "Near \(beacon.major): \(beacon.minor)";
            notification.alertBody = body
            
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            if(foundBeacons[body] == nil) { // show notification if not shown earlier
                // UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            }
            
            foundBeacons.updateValue(body, forKey: body)
            
        case .Immediate:
            self.view.backgroundColor = UIColor.redColor()
            
            let body = "Immediate \(beacon.major): \(beacon.minor)";
            notification.alertBody = body
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            
            if(foundBeacons[body] == nil) { // show notification if not shown earlier
                // UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            }
            
            foundBeacons.updateValue(body, forKey: body)

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

}
