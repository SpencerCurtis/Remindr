//
//  CustomTabBarViewController.swift
//  Remindr
//
//  Created by Spencer Curtis on 1/31/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//

import UIKit

let cancelNewRemindrNotification = Notification.Name("cancelNewRemindr")

class CustomTabBarViewController: UITabBarController, CustomTabBarDelegate {
    
    var customTabBar: CustomTabBar!
    var opaqueViewForRemindrTypeSelection: UIView!
    
    
    override var selectedIndex: Int {
        didSet {
            customTabBar.selectIndex(index: selectedIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomTabBar()
        setUpOpaqueViewForSelectingNewRemindrType()
    }
    
    func constraintsFor(customTabBar: CustomTabBar) {
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = NSLayoutConstraint(item: customTabBar, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: customTabBar, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: customTabBar, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: customTabBar, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1/9, constant: 0)
        
        self.view.addConstraints([leadingConstraint, trailingConstraint, bottomConstraint, heightConstraint])
        
    }
    
    func tabBarButtonTapped(index: Int) {
        selectedIndex = index
    }
    
    func setupCustomTabBar() {
        self.tabBar.isHidden = true
        
        self.tabBar.backgroundColor = .clear
        customTabBar = CustomTabBar()
        customTabBar.delegate = self
        customTabBar.selectIndex(index: 0)
        
        self.view.addSubview(customTabBar)
        constraintsFor(customTabBar: customTabBar)
        
    }
    
    func setUpOpaqueViewForSelectingNewRemindrType() {
        let opaqueView = UIView(frame: UIScreen.main.bounds)
        
        opaqueView.backgroundColor = .black
        opaqueView.alpha = 0
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissOpaqueViewForRemindrTypeSelection))
        let secondTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(notifyCustomTabBarToTransitionToUnselectedState))

        
        opaqueView.addGestureRecognizer(tapRecognizer)
        opaqueView.addGestureRecognizer(secondTapRecognizer)
        
        opaqueViewForRemindrTypeSelection = opaqueView
    }
    
    func addNewRemindrButtonSelected() {
        
        self.view.insertSubview(opaqueViewForRemindrTypeSelection, belowSubview: customTabBar)
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: {
            self.opaqueViewForRemindrTypeSelection.alpha = 0.6
        }, completion: nil)
    }
    
    func addNewRemindrButtonDeselected() {
        dismissOpaqueViewForRemindrTypeSelection()
    }
    
    func notifyCustomTabBarToTransitionToUnselectedState() {
        NotificationCenter.default.post(name: cancelNewRemindrNotification, object: nil)
    }
    
    func dismissOpaqueViewForRemindrTypeSelection() {
        
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: {
            self.opaqueViewForRemindrTypeSelection.alpha = 0
        }) { (_) in
            self.opaqueViewForRemindrTypeSelection.removeFromSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


