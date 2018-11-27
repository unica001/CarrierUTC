//
//  AppDelegate.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    var lat : Double = Double()
    var long : Double = Double()
    var locationManager : CLLocationManager!
    var currentLocation :CLLocation!
    var currentAddress : String!
    var deviceToken  : String = String()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        getCurrentLocation()
        registerForPushNotifications(application: application)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    //MARK: - Location
    func getCurrentLocation(){
        if CLLocationManager.locationServicesEnabled() {            switch(CLLocationManager.authorizationStatus()) {
        case  .denied:
            
            Alert.showAlertWithAction(title: "", message: "nable location from your device Settings", style: .alert, actionTitles: ["SETTING", "CANCEL"], action: {(action) in
                
                if action.title == "SETTING" {
                    let settingsUrl = NSURL(string: UIApplication.openSettingsURLString)
                    UIApplication.shared.open(settingsUrl! as URL, options: [:], completionHandler: nil)
                }
            })
            
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
            
        case .notDetermined:
            print("notDetermined")
            
            
        case .restricted:
            print("restricted")
            
            }
        }
        
        self.getLocation()
    }
    
    // MARK :- Location Manager
    
    func getLocation() -> Void {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.allowsBackgroundLocationUpdates = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = locations.last! as CLLocation
        lat = currentLocation.coordinate.latitude
        long = currentLocation.coordinate.longitude
        
        getAddressFromLatLon()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("1")
            manager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            print("2")
            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            print("3")
            manager.startUpdatingLocation()
            break
        case .restricted:
            print("4")
            break
        case .denied:
            print("5")
            break
        }
    }
    
    func getAddressFromLatLon() {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
       
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = long
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
//                    print(pm.country)
//                    print(pm.locality)
//                    print(pm.subLocality)
//                    print(pm.thoroughfare)
//                    print(pm.postalCode)
//                    print(pm.subThoroughfare)
                    
                    var addressString : String = ""
                    
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! 
                    }
                  
                   
                  
//                    if pm.country != nil {
//                        addressString = addressString + pm.country! + ", "
//                    }
//                    if pm.postalCode != nil {
//                        addressString = addressString + pm.postalCode! + " "
//                    }
                    self.currentAddress = addressString
                    print(addressString)
                }
        })
        
    }

    //MARK: - Device token
    func registerRemoteNotification() {
        let settings = UIUserNotificationSettings(types: [.badge, .alert, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(settings)
    }
    
    func registerForPushNotifications(application: UIApplication) {
        
        if #available(iOS 10.0, *)
        {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            })
        }
            
        else{
            //If user is not on iOS 10 use the old methods we've been using
            let notificationSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            application.registerUserNotificationSettings(notificationSettings)
        }
    }
    
    // MARK: - Remote Notification delegate
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print(token)
        self.deviceToken = token
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        self.deviceToken = "1234"
        print("fail to get token")
    }

}

