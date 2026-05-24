//
//  LocationFetcher.swift
//  MapFlip 2
//
//  Created by Alejandro González on 24/05/26.
//

import CoreLocation

class LocationFetcher : NSObject, CLLocationManagerDelegate {
    var manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
