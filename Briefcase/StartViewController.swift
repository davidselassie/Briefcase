//
//  StartViewController.swift
//  Briefcase
//
//  Created by David Selassie on 11/6/14.
//  Copyright (c) 2014 David Selassie. All rights reserved.
//

import UIKit
import CoreLocation
import Accounts

class StartViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let accountStore = ACAccountStore()

    var gotLocationAccess = false
    var gotTwitterAccess = false
    var twitterAccount: ACAccount?

    override func viewDidLoad() {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()

        self.accountStore.requestAccessToAccountsWithType(
            self.accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter),
            options: nil,
            completion: self.onTwitterAccessGranted)
    }

    func locationManager(
        manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            if status != CLAuthorizationStatus.AuthorizedWhenInUse {
                NSLog("Failed location access: \(status)")
                self.locationManager.requestWhenInUseAuthorization()
            } else {
                NSLog("Got location access.")
                self.gotLocationAccess = true
                self.tryStartRunningGame()
            }
    }

    func onTwitterAccessGranted(granted: Bool, error: NSError!) {
        if granted {
            NSLog("Got Twitter access.")
            self.gotTwitterAccess = true
            let twitterAccounts = self.accountStore.accountsWithAccountType(self.accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter))
            self.twitterAccount = twitterAccounts.first as ACAccount?
            self.tryStartRunningGame()
        } else {
            NSLog("Failed Twitter access: \(error)")
            self.accountStore.requestAccessToAccountsWithType(
                self.accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter),
                options: nil,
                completion: self.onTwitterAccessGranted)
        }
    }

    func tryStartRunningGame() {
        if self.gotTwitterAccess && self.gotLocationAccess {
            self.performSegueWithIdentifier("RunGame", sender: self)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RunGame" {
//            var rgvc: RunGameViewController = segue.destinationViewController as RunGameViewController
//            rgvc.broadcaster = Broadcaster(twitterAccount: self.twitterAccount!)
        }
    }
}
