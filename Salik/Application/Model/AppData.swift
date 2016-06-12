//
//  AppData.swift
//  Salik
//
//  Created by ME on 6/7/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit
import CoreLocation

class AppData: NSObject {
    
    class var sharedInstance: AppData {
        struct Static {
            static let instance: AppData = AppData()
        }
        return Static.instance
    }
    
    var user_location: String!
    var user_comment: String!
    var user_phone_number: String!
    
    var car_info: [[String : String]]!
    var selected_car_index: Int!
    
    var user_current_location: CLLocationCoordinate2D!
    var user_location_latitude: Double!
    var user_location_longitude: Double!
    var user_location_address: String!
    
    var user_city: String!
    var driver_info: [Dictionary<String,AnyObject>]!
    
    override init() {
        user_location = ""
        user_comment = ""
        user_phone_number = ""
        
        car_info = [
            [
                "car_type": "Economy(QAR 30)",
                "car_image" : "economy"
            ],
            [
                "car_type": "SUV(QAR 60)",
                "car_image" : "suv"
            ],
            [
                "car_type": "VIP(QAR 100)",
                "car_image" : "vip"
            ],
            [
                "car_type": "VVIP(QAR 300)",
                "car_image" : "vvip"
            ]
        ]
        
        selected_car_index = -1
        
        driver_info = []
        
    }
    

}
