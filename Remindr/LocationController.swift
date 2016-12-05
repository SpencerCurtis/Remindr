//
//  LocationController.swift
//  Capstoneremindr
//
//  Created by Spencer Curtis on 3/25/16.
//  Copyright © 2016 Spencer Curtis. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import AudioToolbox

class LocationController: NSObject, CLLocationManagerDelegate {
    static let sharedController = LocationController()
    
    var currentLocation: CLLocation?
    
    var selectedLocation: CLLocation?
    
    let locationManager = CLLocationManager()
    
    var hasLocation = Notification.Name(rawValue: "hasLocation")
    
    var remindr: Remindr?
    
    var atALocationTextName: String?
    var atALocationTextAddress: String?
    
    let authState = CLLocationManager.authorizationStatus()
    
    
    override init() {
        super.init()
        remindr = nil
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.pausesLocationUpdatesAutomatically = true
    }
    
    var remindrsUsingLocationCount: Int {
        return UserDefaults.standard.integer(forKey: "remindrsUsingLocationCount")
    }
    
    func increaseLocationCount() {
        var remindrsUsingLocationCount = UserDefaults.standard.integer(forKey: "remindrsUsingLocationCount")
        remindrsUsingLocationCount += 1
        UserDefaults.standard.set(remindrsUsingLocationCount, forKey: "remindrsUsingLocationCount")
    }
    
    func decreaseLocationCount() {
        var remindrsUsingLocationCount = UserDefaults.standard.integer(forKey: "remindrsUsingLocationCount")
        if remindrsUsingLocationCount > 0 { remindrsUsingLocationCount -= 1 }
        UserDefaults.standard.set(remindrsUsingLocationCount, forKey: "remindrsUsingLocationCount")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = locations.last
        NotificationCenter.default.post(name: hasLocation, object: self)
    }
    
    func displayAlert(_ viewController: UIViewController, remindr: Remindr) {
        let alert = UIAlertController(title: remindr.title, message: remindr.notes, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okayAction)
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        var remindrForRegion: Remindr? = nil
        for remindr in remindrController.sharedController.remindrs {
            if remindr.title == region.identifier {
                remindrForRegion = remindr
            }
        }
        if let remindr = remindrForRegion {
            if UIApplication.shared.applicationState == .active {
                NotificationController.sharedController.alertFor(remindr: remindr)
                print("Geofence triggered")
            } else {
                NotificationController.sharedController.notificationFor(remindr: remindr)
                print("Geofence triggered")
            }
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        var remindrForRegion: Remindr? = nil
        for remindr in remindrController.sharedController.remindrs {
            if remindr.title == region.identifier {
                remindrForRegion = remindr
            }
        }
        if let remindr = remindrForRegion {
            if UIApplication.shared.applicationState == .active {
                NotificationController.sharedController.alertFor(remindr: remindr)
                print("Geofence triggered")
            } else {
                NotificationController.sharedController.notificationFor(remindr: remindr)
                print("Geofence triggered")
            }
        }
    }
    
    
    
    func requestLocations() {
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    func requestAuthorization() {
        
        if authState == CLAuthorizationStatus.notDetermined || authState == CLAuthorizationStatus.restricted {
            locationManager.requestAlwaysAuthorization()
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.delegate = self
            locationManager.requestLocation()
        } else {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed when getting users location")
    }
}



