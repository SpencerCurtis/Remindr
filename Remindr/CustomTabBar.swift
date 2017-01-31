//
//  CustomTabBar.swift
//  Remindr
//
//  Created by Spencer Curtis on 1/31/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBar {

    weak var dataSource: CustomTabBarDataSource?
    
    var tabBarItems: [UITabBarItem] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

}


protocol CustomTabBarDataSource: class {
    func tabBarItemsInCustomTabBar(tabBarView: CustomTabBar) -> [UITabBarItem]
}
