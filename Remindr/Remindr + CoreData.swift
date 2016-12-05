//
//  remindr.swift
//  Capstoneremindr
//
//  Created by Spencer Curtis on 3/28/16.
//  Copyright © 2016 Spencer Curtis. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation


extension Remindr {
    
    convenience init(title: String, notes: String, alertLabelText: String, isComplete: Bool = false, creationDate: Date = Date(), latitude: CLLocationDegrees, longitude: CLLocationDegrees, context: NSManagedObjectContext = Stack.context) {

        let entity = NSEntityDescription.entity(forEntityName: "remindr", in: context)
        
        self.init(entity: entity!, insertInto: context)
        
        self.title = title
        self.notes = notes
        self.isComplete = isComplete as NSNumber?
        self.alertLabelText = alertLabelText
        self.creationDate = creationDate as NSDate?
        self.locationLatitude = latitude as NSNumber?
        self.locationLongitude = longitude as NSNumber?
    }
    
    convenience init(title: String, notes: String, remindrTime: Date, alertLabelText: String, isComplete: Bool = false, creationDate: Date = Date(), context: NSManagedObjectContext = Stack.context) {
        
        let entity = NSEntityDescription.entity(forEntityName: "remindr", in: context)
        
        self.init(entity: entity!, insertInto: context)
        
        self.title = title
        self.notes = notes
        self.remindrTime = remindrTime as NSDate?
        self.alertLabelText = alertLabelText
        self.isComplete = isComplete as NSNumber?
        self.creationDate = creationDate as NSDate?
    }
    var location: CLLocation? {
        if let latitude = locationLatitude?.doubleValue, let longitude = locationLongitude?.doubleValue {
            return CLLocation(latitude: latitude, longitude: longitude)
        } else {
            return nil
        }
    }
}

extension Remindr {
    
    fileprivate var kAlertLabelText: String { return "alertLabelText" }
    fileprivate var kCreationDate: String { return "creationDate" }
    fileprivate var kHasBeenNotified: String { return "hasBeenNotified" }
    fileprivate var kIsComplete: String { return "isComplete" }
    fileprivate var kLocationLatitude: String { return "locationLatitude" }
    fileprivate var kLocationLongitude: String { return "locationLongitude" }
    fileprivate var kNotes: String { return "notes" }
    fileprivate var kRemindrTime: String { return "remindrTime" }
    fileprivate var kTitle: String { return "title" }
    fileprivate var kAtALocationLabelText: String { return "atALocationLabelText" }
    
    var dictionaryRepresentation: [String: Any] {
        
        guard let alertLabelText = alertLabelText,
            let creationDate = creationDate,
            let hasBeenNotified = hasBeenNotified,
            let isComplete = isComplete,
            let locationLatitude = locationLatitude,
            let locationLongitude = locationLongitude,
            let notes = notes,
            let title = title,
            let remindrTime = remindrTime
            else { return [:] }
        
        return [kAlertLabelText: alertLabelText, kCreationDate: creationDate, kHasBeenNotified: hasBeenNotified, kIsComplete: isComplete, kLocationLatitude: locationLatitude, kLocationLongitude: locationLongitude, kNotes: notes, kRemindrTime: remindrTime , kTitle: title, kAtALocationLabelText: atALocationLabelText as AnyObject? ?? ""]
        
    }
    
    convenience init?(dictionary: [String: Any], context: NSManagedObjectContext = Stack.context) {
        
        
        guard let entity = NSEntityDescription.entity(forEntityName: "remindr", in:  context) else { return nil }
        
        self.init(entity: entity, insertInto: context)
        
        guard let alertLabelText = dictionary[kAlertLabelText] as? String,
            let creationDate = dictionary[kCreationDate] as? NSDate,
            let hasBeenNotified = dictionary[kHasBeenNotified] as? NSNumber,
            let isComplete = dictionary[kIsComplete] as? NSNumber,
            let locationLatitude = dictionary[kLocationLatitude] as? NSNumber,
            let locationLongitude = dictionary[kLocationLongitude] as? NSNumber,
            let notes = dictionary[kNotes] as? String,
            let title = dictionary[kTitle] as? String,
            let remindrTime = dictionary[kRemindrTime] as? NSDate
        else { return nil }
        
        self.alertLabelText = alertLabelText
        self.creationDate = creationDate
        self.hasBeenNotified = hasBeenNotified
        self.isComplete = isComplete
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
        self.notes = notes
        self.title = title
        self.remindrTime = remindrTime
    }
}
