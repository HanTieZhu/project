//
//  MapViewController.swift
//  Salik
//
//  Created by ME on 6/9/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit
import GoogleMaps


class MapViewController: BaseViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        
        initData()
        initView()
        addMakerForAllDriver()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClose(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func initData(){

    }
    
    func initView(){
        reverseGeocodeCoordinate(self.appData.user_current_location)
        setMaker(self.appData.user_current_location)
        marker.map = mapView
    }

    
    func setMaker(coordinate: CLLocationCoordinate2D){
        marker.position = coordinate;
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.icon = UIImage(named: "map_pin")
        marker.title = "I am here"
        marker.snippet = addressLabel.text
        
        mapView.selectedMarker = marker
    }
    
    func addMakerForDriver(driver: Dictionary<String, AnyObject>){
        let driverMaker = GMSMarker()

        let latitude = String(driver[DRIVER_LOCATION_LATITUDE]!)
        let longitude = String(driver[DRIVER_LOCATION_LONGITUDE]!)
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(latitude)!, Double(longitude)!)
        driverMaker.position = coordinate
        driverMaker.appearAnimation = kGMSMarkerAnimationPop
        driverMaker.title = String(driver[DRIVER_FIRST_NAME]!)+" "+String(driver[DRIVER_LAST_NAME]!)
        driverMaker.snippet = String(driver[DRIVER_LOCATION_ADDRESS]!)
        
        driverMaker.map = mapView
        
    }
    
    func addMakerForAllDriver(){
        for driver in appData.driver_info {
            addMakerForDriver(driver)
        }
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                let lines = address.lines
                print(lines)
                self.addressLabel.text = lines!.joinWithSeparator(" ")
                self.appData.user_location = self.addressLabel.text
                UIView.animateWithDuration(0.25) {
                    self.view.layoutIfNeeded()
                }
                
                self.setMaker(coordinate)
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 7, bearing: 0, viewingAngle: 0)
            
            locationManager.stopUpdatingLocation()

        }
        
    }
    
    //MARK: GMSMapViewDelegate
    func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
//        reverseGeocodeCoordinate(position.target)
    }
    
    func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
//        setMaker(coordinate)
        reverseGeocodeCoordinate(coordinate)
    }
    
    func didTapMyLocationButtonForMapView(mapView: GMSMapView) -> Bool {
        mapView.camera = GMSCameraPosition(target: self.appData.user_current_location, zoom: 7, bearing: 0, viewingAngle: 0)

//        setMaker(self.appData.user_current_location)
        reverseGeocodeCoordinate(self.appData.user_current_location)
        return true
    }

}
