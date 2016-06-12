//
//  Constant.swift
//  Salik
//
//  Created by ME on 6/8/16.
//  Copyright © 2016 com. All rights reserved.
//
import UIKit
import Foundation

    //Google API Key
    let GOOGLE_MAP_API_KEY = "AIzaSyCbThqor3eN4yCyI4fSU9s47z_In05TDJ8"
    
    //API URL
    let SERVER_URL = "http://172.16.1.192:8080/Salik"
//    let SERVER_URL = "http://138.128.178.90/~oczxbfkm/Salik/index.php"


    let API_KEY = "12345"
    let API_URL = SERVER_URL + "/api"
    let API_SIGN = SERVER_URL + "/api/sign"
    let API_ORDER = SERVER_URL + "/api/order"

    
    // Request Params (Order)
    let CAR_TYPE = "car_id"
    let ORDER_LOCATION = "order_location"
    let ORDER_COMMENT = "order_comment"
    let ORDER_PHONE_NUMBER = "order_phone_number"

    //Request Params (Sign)
    let USER_DEVICE_ID = "user_device_id"
    let USER_LOCATION_ADDRESS = "user_location_address"
    let USER_LOCATION_LATITUDE = "user_location_latitude"
    let USER_LOCATION_LONGITUDE = "user_location_longitude"
    let USER_CITY = "user_city"

    //Result
    let STATUS = "status"
    let MESSAGE = "msg"

    //User Info
    let USER_ID = "user_id"
    let ADDRESS = "address"

    //Driver Info
    let DRIVERS = "drivers"
    let DRIVER_ID = "driver_id"
    let DRIVER_FIRST_NAME = "driver_first_name"
    let DRIVER_LAST_NAME = "driver_last_name"
    let DRIVER_LOCATION_ADDRESS = "driver_location_address"
    let DRIVER_LOCATION_LATITUDE = "driver_location_latitude"
    let DRIVER_LOCATION_LONGITUDE = "driver_location_longitude"
    let DRIVER_GCM_ID = "driver_gcm_id"
    let DRIVER_DISTANCE = "distance"
