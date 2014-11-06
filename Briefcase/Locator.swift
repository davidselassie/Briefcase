//
//  Locator.swift
//  Briefcase
//
//  Created by David Selassie on 11/6/14.
//  Copyright (c) 2014 David Selassie. All rights reserved.
//

import Foundation
import CoreLocation

class Locator {
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    init() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.activityType = CLActivityType.Fitness
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(
        manager: CLLocationManager!,
        didUpdateLocations locations: [AnyObject]!) {

    }
    
    func currentLocation() -> CLLocation {
        return self.locationManager.location
    }
    
    func currentStringLocation() -> String {
        return "XX"
    }
}
