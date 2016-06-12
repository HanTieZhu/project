//
//  AppDelegate.swift
//  Salik
//
//  Created by ME on 6/7/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit
//import IQKeyboardManagerSwift
import GoogleMaps
import AdSupport

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()
    var appController: AppController = AppController.sharedInstance
    var appData: AppData = AppData.sharedInstance

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        IQKeyboardManager.sharedManager().enable = true
        GMSServices.provideAPIKey(GOOGLE_MAP_API_KEY)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 804.17 //0.5 miles

        appController.setUserDefault(USER_DEVICE_ID, val: ASIdentifierManager.sharedManager().advertisingIdentifier!.UUIDString)
        print(appController.getUserDefault(USER_DEVICE_ID))
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func sign(){
        let params: NSMutableDictionary = NSMutableDictionary()
        params.setValue(appController.getUserDefault(USER_DEVICE_ID), forKey: USER_DEVICE_ID)
        params.setValue(appData.user_current_location.latitude, forKey: USER_LOCATION_LATITUDE)
        params.setValue(appData.user_current_location.longitude, forKey: USER_LOCATION_LONGITUDE)
        params.setValue(appData.user_location_address, forKey: USER_LOCATION_ADDRESS)
        params.setValue(appData.user_city, forKey: USER_CITY)
        
        appController.httpRequest(API_SIGN, params: params, completion: {
            result in
            
                let status: Int = result.objectForKey(STATUS) as!  Int
                if status == 1 {

                    let user_id: Int = result.objectForKey(USER_ID) as! Int
                    self.appController.setUserDefault(USER_ID, val: user_id)
                    
                    let drivers: [Dictionary<String,AnyObject>]! = result.objectForKey(DRIVERS) as! [Dictionary<String,AnyObject>]!
                        self.appData.driver_info = drivers                
                }
            
        }, errors: {
                
        })
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address: GMSAddress = response?.firstResult() {
                
                let lines = address.lines
                print(lines)
                self.appData.user_location_address = lines!.joinWithSeparator(" ")
                self.appData.user_location_latitude = coordinate.latitude
                self.appData.user_location_longitude = coordinate.longitude
                self.appData.user_city = address.locality
                self.sign()
            }
        }
    }
    
    //MARK: CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print(location)
            appData.user_current_location = location.coordinate
            
//            CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in
//                
//                if (error != nil) {
//                    print("Error: " + error!.localizedDescription)
//                    return
//                }
//                
//                if placemarks!.count > 0 {
//                    
//                    let pm = placemarks![0] as CLPlacemark
//                    self.displayLocationInfo(pm)
//
//                } else {
//                    print("Error with data")
//                }
//            })
            reverseGeocodeCoordinate(CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude))
        }
        
        locationManager.stopUpdatingLocation()
        
    }
    
//    func displayLocationInfo(placemark: CLPlacemark) {
//        self.locationManager.stopUpdatingLocation()
//        
//        let subStreet = placemark.subThoroughfare
//        let street = placemark.thoroughfare
//        let postalCode = placemark.postalCode
//        let subDepartment = placemark.subAdministrativeArea
//        let department = placemark.administrativeArea
//        let city = placemark.locality
//        let country = placemark.country
//        let latitude = placemark.location!.coordinate.latitude
//        let longitude = placemark.location!.coordinate.longitude
//        let date = placemark.location!.timestamp
//        
//        print(subStreet)
//        print(street)
//        print(postalCode)
//        print(subDepartment)
//        print(department)
//        print(city)
//        print(country)
//        print(latitude)
//        print(longitude)
//        print(date)
//        
//        appData.user_location_latitude = latitude
//        appData.user_location_longitude = longitude
//        appData.user_location_address = street!+","+department!+","+city!+","+country!
//        
//        self.sign()
//    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location " + error.localizedDescription)
    }
}

