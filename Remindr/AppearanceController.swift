//
//  AppearanceController.swift
//  Capstoneremindr
//
//  Created by Spencer Curtis on 3/23/16.
//  Copyright © 2016 Spencer Curtis. All rights reserved.
//

import Foundation
import UIKit

class AppearanceController {
    
    static func initializeAppearanceDefaults() {
        UISegmentedControl.appearance().tintColor = UIColor.customCyanColor()
        UINavigationBar.appearance().tintColor = UIColor.customCyanColor()
    }
}

