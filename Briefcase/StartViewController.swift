//
//  StartViewController.swift
//  Briefcase
//
//  Created by David Selassie on 11/6/14.
//  Copyright (c) 2014 David Selassie. All rights reserved.
//

import UIKit
import CoreLocation

class StartViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(
        manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            if status != CLAuthorizationStatus.AuthorizedWhenInUse {
                self.locationManager.requestWhenInUseAuthorization()
            } else {
                self.startRunningGame()
            }
    }

    func startRunningGame() {
        self.performSegueWithIdentifier("RunGame", sender: self)
    }
}
