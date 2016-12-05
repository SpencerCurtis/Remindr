//
//  FifthViewController.swift
//  Capstoneremindr
//
//  Created by Spencer Curtis on 5/9/16.
//  Copyright © 2016 Spencer Curtis. All rights reserved.
//

import UIKit
import UserNotifications

class FifthViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(registerForNotifications), userInfo: nil, repeats: false)
        let _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(requestLocationAuthorization), userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestLocationAuthorization() {
        LocationController.sharedController.requestAuthorization()
    }
    
    func registerForNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { (_, error) in
            if let error = error { print(error.localizedDescription) }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
