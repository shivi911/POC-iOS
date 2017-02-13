//
//  AppDelegate.swift
//  PNDemo
//
//  Created by Shivi on 2/11/17.
//  Copyright © 2017 NaviSpin. All rights reserved.
//
// References: http://stackoverflow.com/questions/5056689/didreceiveremotenotification-when-in-background
// http://stackoverflow.com/questions/36323903/silent-push-notification-payload
// https://www.raywenderlich.com/123862/push-notifications-tutorial
// http://www.appcoda.com/push-notification-ios/
//


import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let center = UNUserNotificationCenter.current()
    var vc = ViewController()
    var fromNotifTray = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        registerForPushNotifications(application: application)
        
        // vc.showAlertPopup(title: "AppStart", body: "didFinishLaunchingWithOptions")
        // Check if launched from notification
        // If the app wasn’t running and the user launches it by tapping the push notification,
        // the push notification is passed to the app in the launchOptions
        if let notification = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [String: AnyObject] {
        
            print("launched from notif tray")
            fromNotifTray = true
            // vc.showAlertPopup(title: "AppStart", body: "Launched From Notif tray")
           // showLocalNotification(body: "Launched from Notification tray")
            incrementBadgeNumberBy(badgeNumberIncrement: 3)
        }
        else {
            fromNotifTray = false
        }
        
        
        return true
    }
    
    func registerForPushNotifications(application: UIApplication) {
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        
        // UNUserNotificationCenter.current().delegate = self
        /*
         let settings: UIUserNotificationSettings =
         UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
         application.registerUserNotificationSettings(settings)
         */
        
        /*
         
         let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
         let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
         
         application.registerUserNotificationSettings(pushNotificationSettings)
         */
        
        application.registerForRemoteNotifications()
    }

    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
        
        // Persist it in your backend in case it's new
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    /*
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("DEVICE TOKEN = \(deviceToken)")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error)
    }
 */
    
    // Push notification received
    
    /*
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print("Push notification received: \(data)")

        let alertController = UIAlertController(title: "Hello  Coders", message: "didReceiveRemote", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        showLocalNotification(body:"Received Remote Notif")
    }
 */
 
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        showLocalNotification(body:"Received Remote Notif backgroundfetchresult")
        /*
        if(fromNotifTray == true) {
            fromNotifTray = false
            showAlertPopup(title: "didReceiveRemoteNotif", body: "Received Remote notif backgroundfetchResult - App launched from NotifTray")
        }
 */
        print("APNS data  \(userInfo)")
        if ( application.applicationState == UIApplicationState.inactive ) {
            // Inactive - the user has tapped in the notification when app was closed or in background
            showAlertPopup(title: "didReceiveRemoteNotif", body: "Inactive - the user has tapped in the notification when app was closed or in background")
        }
        else if ( application.applicationState == UIApplicationState.background ) {
            // Background - notification has arrived when app was in background
            // check for content-available true here
            showAlertPopup(title: "didReceiveRemoteNotif", body: "Background - notification has arrived when app was in background")
        }
        else if ( application.applicationState == UIApplicationState.active ) {
            // app was already in foreground
            showAlertPopup(title: "didReceiveRemoteNotif", body: "Received Remote notif backgroundfetchResult - Foreground")
        }
        else {
            showAlertPopup(title: "didReceiveRemoteNotif Back-", body: "Received Remote notif backgroundfetchResult - Back->Fore")
        }
        
    
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    
    /*
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print(userInfo)
    }
 */
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func showLocalNotification(body: String) {
        let notification = UILocalNotification()
        notification.alertBody = body
        notification.alertAction = "open"
        UIApplication.shared.presentLocalNotificationNow(notification)
    }

    func showAlertPopup(title: String, body: String) {
        let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    func incrementBadgeNumberBy(badgeNumberIncrement: Int) {
        let currentBadgeNumber = UIApplication.shared.applicationIconBadgeNumber
        let updatedBadgeNumber = currentBadgeNumber + badgeNumberIncrement
        if (updatedBadgeNumber > -1) {
            UIApplication.shared.applicationIconBadgeNumber = updatedBadgeNumber
        }
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // showLocalNotification(body:"willPresentNotification")
        let alertController = UIAlertController(title: "Hello  Coders", message: "Will Present Notif", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        print("User Info will Present = ",notification.request.content.userInfo)
        completionHandler([.alert, .badge, .sound])
    }
    
    //Called to let your app know which action was selected by the user for a given notification.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // showLocalNotification(body:"didReceiveNotification")
        let alertController = UIAlertController(title: "Hello  Coders", message: "didReceive", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        print("User Info didReceive = ",response.notification.request.content.userInfo)
        completionHandler()
    }
    
}

