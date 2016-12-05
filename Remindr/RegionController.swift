//
//  RegionController.swift
//  Capstoneremindr
//
//  Created by Spencer Curtis on 5/4/16.
//  Copyright © 2016 Spencer Curtis. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class RegionController {
    
    static let sharedController = RegionController()
    
    func regionWithremindrUponArriving(_ remindr: Remindr) -> CLCircularRegion? {
        if LocationController.sharedController.locationManager.monitoredRegions.count <= 20 {
            let region = CLCircularRegion(center: remindr.location!.coordinate, radius: 300, identifier: remindr.title!)
            
            region.notifyOnEntry = true
            region.notifyOnExit = false
            return region
        } else {
            simpleAlert("Error", message: "You can only have 20 remindrs that use location at a time. Please delete or check the ones you don't need anymore, then try again.")
            return nil
        }
        
        
    }
    
    func regionWithremindrUponMoving(_ remindr: Remindr) -> CLCircularRegion? {
        if LocationController.sharedController.locationManager.monitoredRegions.count <= 20 {
            let region = CLCircularRegion(center: remindr.location!.coordinate, radius: 300, identifier: remindr.title!)
            region.notifyOnEntry = false
            region.notifyOnExit = true
            return region
        } else {
            simpleAlert("Error", message: "You can only have 20 remindrs that use location at a time. Please delete or check the ones you don't need anymore, then try again.")
            return nil
        }
        
    }
    
    func startMonitoringremindrUponMoving(_ remindr: Remindr) {
        
        guard CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) == true else {
            simpleAlert("Error", message: "Geofencing is not supported on this device")
            return
        }
        if let region = regionWithremindrUponMoving(remindr) {
            LocationController.sharedController.locationManager.startMonitoring(for: region)
        }
    }
    
    
    
    func startMonitoringremindrUponArriving(_ remindr: Remindr) {
        guard CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) == true else {
            simpleAlert("Error", message: "Geofencing is not supported on this device")
            return
        }
        if let region = regionWithremindrUponArriving(remindr) {
            LocationController.sharedController.locationManager.startMonitoring(for: region)
        }
    }
    
    func stopMonitoringremindr(_ remindr: Remindr) {
        for region in LocationController.sharedController.locationManager.monitoredRegions {
            if let circularRegion = region as? CLCircularRegion {
                if circularRegion.identifier == remindr.title {
                    LocationController.sharedController.locationManager.stopMonitoring(for: circularRegion)
                }
            }
        }
    }
}


func simpleAlert(_ title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
    alert.addAction(dismissAction)
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
}
