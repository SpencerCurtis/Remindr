//
//  remindrController.swift
//  Capstoneremindr
//
//  Created by Spencer Curtis on 3/23/16.
//  Copyright © 2016 Spencer Curtis. All rights reserved.
//

import Foundation
import CoreData
import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class remindrController {
    
    static let sharedController = remindrController()
    
    var remindrs: [Remindr] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Remindr")
        
        do {
            guard let remindrs = try Stack.context.fetch(request) as? [Remindr] else { return [] }
            let remindrsArray = remindrs.sorted(by: {$0.creationDate?.timeIntervalSince1970 > $1.creationDate?.timeIntervalSince1970})
            return remindrsArray
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    var completeRemindrs: [Remindr] {
        return remindrs.filter({$0.isComplete!.boolValue})
    }
    
    var incompleteRemindrs: [Remindr] {
        return remindrs.filter({!$0.isComplete!.boolValue})
    }
    
    var incompleteremindrsWithLocationUponLeaving: [Remindr] {
        return incompleteRemindrs.filter({$0.alertLabelText == "Upon Moving"})
    }
    
    var incompleteremindrsWithLocationUponArriving: [Remindr] {
        return incompleteRemindrs.filter({$0.alertLabelText == "Upon Arriving"})
    }
    
    
    func addremindr(_ remindr: Remindr) {
        if remindr.alertLabelText != "Upon Arriving" && remindr.alertLabelText != "Upon Moving" {
            saveToPersistentStorage()
        } else if remindr.alertLabelText == "Upon Arriving" && LocationController.sharedController.locationManager.monitoredRegions.count <= 20 {
            RegionController.sharedController.startMonitoringremindrUponArriving(remindr)
            remindr.atALocationLabelText = LocationController.sharedController.atALocationTextName
            saveToPersistentStorage()
        } else if remindr.alertLabelText == "Upon Moving" && LocationController.sharedController.locationManager.monitoredRegions.count <= 20 {
            RegionController.sharedController.startMonitoringremindrUponMoving(remindr)
            saveToPersistentStorage()
        } else if LocationController.sharedController.locationManager.monitoredRegions.count > 20 {
            simpleAlert("Error", message: "You can only have 20 remindrs that use location at a time. Please delete or check ones you don't need anymore, then try again.")
        }
    }
    
    func remove(remindr: Remindr) {
        
        remindr.managedObjectContext?.delete(remindr)
        if remindr.location != nil {
            LocationController.sharedController.decreaseLocationCount()
        }
        if remindr.alertLabelText == "Upon Arriving" {
            RegionController.sharedController.stopMonitoring(remindr: remindr)
        }
        saveToPersistentStorage()
        
        
        NotificationController.sharedController.removeNotificationFor(remindr: remindr)
    }
    
    // MARK: - Persistence
    
    func saveToiCloud() {
        let dictionaries = remindrs.map({$0.dictionaryRepresentation})
        NSUbiquitousKeyValueStore.default().set(dictionaries, forKey: "remindrs")
    }
    
    func loadFromiCloud() {
        let remindrs = NSUbiquitousKeyValueStore.default().object(forKey: "remindrs")
        guard let remindrsArray = remindrs as? [[String: AnyObject]] else { print("Failed to get remindrs"); return }
        _ = remindrsArray.flatMap({Remindr(dictionary: $0)})
        saveToPersistentStorage()
    }
    
    func loadFromPersistentStorage() {
        
    }
    
    func saveToPersistentStorage() {
        
        do {
            try Stack.context.save()
        } catch {
            print("Error saving Managed Object Context. Items not saved.")
        }
        
        saveToiCloud()
    }
}
