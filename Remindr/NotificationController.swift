//
//  NotificationController.swift
//  Capstoneremindr
//
//  Created by Spencer Curtis on 5/4/16.
//  Copyright © 2016 Spencer Curtis. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox
import UserNotifications

class NotificationController {
    
    static let sharedController = NotificationController()
    
    func alertFor(remindr: Remindr) {
        let vc = UIApplication.shared.keyWindow?.rootViewController
        let alert = UIAlertController(title: remindr.title, message: remindr.notes, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okayAction)
        if let vc = vc {
            vc.present(alert, animated: true, completion: nil)
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }
    
    func notificationFor(remindr: Remindr, with fireTime: TimeInterval? = nil) {
        guard let remindrTitle = remindr.title else { NSLog("No title found for remindr, cannot create a notification."); return }
        
        let identifier = remindrTitle
        let content = UNMutableNotificationContent()
    
        content.body = remindrTitle
        
        content.sound = UNNotificationSound.default()
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: fireTime ?? 1, repeats: false)

        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            guard let error = error else { print("Successfully scheduled notification"); return }
            print(error.localizedDescription)
        }
    }
    
    func sendNotificationForRemindrWithTime(_ remindr: Remindr, fireDate: Date) {
        if remindr.hasBeenNotified == false {
            NotificationController.sharedController.alertFor(remindr: remindr)
            
            
            NotificationController.sharedController.notificationFor(remindr: remindr, with: remindr.remindrTime?.timeIntervalSinceNow)
            remindr.hasBeenNotified = true
            remindrController.sharedController.saveToPersistentStorage()
            
            
        }
    }
    
    func removeNotificationFor(remindr: Remindr) {
        guard let remindrTitle = remindr.title else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [remindrTitle])
    }
    
}

// TODO: make a "Mark as Complete" button on the alerts and notifications.
