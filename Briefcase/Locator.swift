//
//  Locator.swift
//  Briefcase
//
//  Created by David Selassie on 11/6/14.
//  Copyright (c) 2014 David Selassie. All rights reserved.
//

import Foundation
import CoreLocation
import AddressBookUI

typealias LocatedHandler = (String) -> Void

class Locator: NSObject, CLLocationManagerDelegate {
    internal let locationManager = CLLocationManager()
    internal let geocoder = CLGeocoder()

    internal var callback: LocatedHandler?
    
    override init() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.activityType = CLActivityType.Fitness
        self.locationManager.startUpdatingLocation()
        super.init()
    }

    internal func locationManager(
        manager: CLLocationManager!,
        didUpdateLocations locations: [AnyObject]!) {
            if let callback = self.callback {
                self.reverseGeocode(manager.location, callback: callback)
                self.callback = nil
            }
    }
    
    func currentLocation(callback: LocatedHandler) {
        if let knownLocation = self.locationManager.location {
            self.reverseGeocode(knownLocation, callback: callback)
        } else {
            self.callback = callback
        }
    }

    internal func reverseGeocode(location: CLLocation, callback: LocatedHandler) {
        self.geocoder.reverseGeocodeLocation(location, completionHandler: {
            (placemarks: [AnyObject]!, error: NSError!) -> Void in
            let placemark = placemarks.first? as CLPlacemark
            callback(self.prettyString(placemark))
        })
    }

    internal func prettyString(placemark: CLPlacemark) -> String {
        return ABCreateStringWithAddressDictionary(placemark.addressDictionary, false)
    }
}
