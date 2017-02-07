//
//  CustomTabBarView.swift
//  Remindr
//
//  Created by Spencer Curtis on 1/31/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//

import UIKit

class CustomTabBar: UIView {
    
    weak var delegate: CustomTabBarDelegate?
    
    var incompleteListButton = UIButton()
    var incompleteListImageView = UIImageView()
    
    var completeListButton = UIButton()
    var completeListImageView = UIImageView()
    
    var newRemindrButton = UIButton()
    
    enum TabSelection {
        case incomplete
        case complete
    }
    
    var currentTabSelection: TabSelection = .incomplete
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        incompleteListButton.tag = 0
        completeListButton.tag = 1
        
        self.completeListButton.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchDown)
        self.incompleteListButton.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchDown)
        self.backgroundColor = .clear
        setupBarItems()
        setupConstraints()
        let notificationName = Notification.Name("TelekinesisDidChangeStyleKitNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(resetImageWithTelekinesis), name: notificationName, object: nil)
        
    }
    
    override func draw(_ rect: CGRect) {
        CustomTabBarStyleKit.drawCustomTabBar(frame: self.bounds, resizing: .aspectFill)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetImageWithTelekinesis() {
        
        newRemindrButton.setImage(TabBarIconStyleKit.imageOfMiddleTabBarButtonUnselected, for: .normal)
        
        if currentTabSelection == .incomplete {
            incompleteListImageView.image = TabBarIconStyleKit.imageOfIncompleteListIconSelected
            completeListImageView.image = TabBarIconStyleKit.imageOfCompleteListIconUnselected
        } else {
            incompleteListImageView.image = TabBarIconStyleKit.imageOfIncompleteListIconUnselected
            completeListImageView.image = TabBarIconStyleKit.imageOfCompleteListIconSelected
        }
        
        
    }
    
    func setupBarItems() {
        
        // Incomplete List (change icons later)
        incompleteListImageView.contentMode = .scaleAspectFit
        self.addSubview(incompleteListImageView)
        self.addSubview(incompleteListButton)
        
        // Complete List
        completeListImageView.contentMode = .scaleAspectFit
        self.addSubview(completeListImageView)
        self.addSubview(completeListButton)
        
        // New Remindr Button
        newRemindrButton.setImage(TabBarIconStyleKit.imageOfMiddleTabBarButtonUnselected, for: .normal)
        self.addSubview(newRemindrButton)
        
    }
    
    func setupConstraints() {
        incompleteListImageView.translatesAutoresizingMaskIntoConstraints = false
        incompleteListButton.translatesAutoresizingMaskIntoConstraints = false
        completeListImageView.translatesAutoresizingMaskIntoConstraints = false
        completeListButton.translatesAutoresizingMaskIntoConstraints = false
        newRemindrButton.translatesAutoresizingMaskIntoConstraints = false
        
        let incompleteListButtonLeading = NSLayoutConstraint(item: incompleteListButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let incompleteListButtonTop = NSLayoutConstraint(item: incompleteListButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let incompleteListButtonBottom = NSLayoutConstraint(item: incompleteListButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let incompleteListButtonWidth = NSLayoutConstraint(item: incompleteListButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1/2, constant: 0)
        
        let incompleteListImageViewCenterX = NSLayoutConstraint(item: incompleteListImageView, attribute: .centerX, relatedBy: .equal, toItem: incompleteListButton, attribute: .centerX, multiplier: 2/3, constant: 0)
        let incompleteListImageViewCenterY = NSLayoutConstraint(item: incompleteListImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 5/4, constant: 0)
        let incompleteListImageViewHeight = NSLayoutConstraint(item: incompleteListImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 3/5, constant: 0)
        let incompleteListImageViewWidth = NSLayoutConstraint(item: incompleteListImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1/2, constant: 0)
        
        let completeListButtonTrailing = NSLayoutConstraint(item: completeListButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let completeListButtonTop = NSLayoutConstraint(item: completeListButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let completeListButtonBottom = NSLayoutConstraint(item: completeListButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let completeListButtonWidth = NSLayoutConstraint(item: completeListButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1/2, constant: 0)
        
        let completeListImageViewCenterX = NSLayoutConstraint(item: completeListImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 5/3, constant: 0)
        let completeListImageViewCenterY = NSLayoutConstraint(item: completeListImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 5/4, constant: 0)
        let completeListImageViewHeight = NSLayoutConstraint(item: completeListImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 3/5, constant: 0)
        let completeListImageViewWidth = NSLayoutConstraint(item: completeListImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1/2, constant: 0)
        
        let newRemindrButtonCenterX = NSLayoutConstraint(item: newRemindrButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let newRemindrButtonCenterY = NSLayoutConstraint(item: newRemindrButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -2)
        let newRemindrButtonHeight = NSLayoutConstraint(item: newRemindrButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 7/8, constant: 0)
        let newRemindrButtonWidth = NSLayoutConstraint(item: newRemindrButton, attribute: .width, relatedBy: .equal, toItem: newRemindrButton, attribute: .height, multiplier: 1, constant: 0)
        
        
        
        
        
        self.addConstraints([incompleteListButtonLeading, incompleteListButtonTop, incompleteListButtonBottom, incompleteListButtonWidth, incompleteListImageViewCenterX, incompleteListImageViewCenterY, incompleteListImageViewHeight, incompleteListImageViewWidth,completeListButtonTrailing, completeListButtonTop, completeListButtonBottom, completeListButtonWidth, completeListImageViewCenterX, completeListImageViewCenterY, completeListImageViewHeight, completeListImageViewWidth, newRemindrButtonCenterX, newRemindrButtonCenterY,
                             newRemindrButtonHeight, newRemindrButtonWidth])
        
    }
    
    
    func selectIndex(index: Int) {
        
        incompleteListImageView.image = TabBarIconStyleKit.imageOfIncompleteListIconUnselected
        completeListImageView.image = TabBarIconStyleKit.imageOfCompleteListIconUnselected
        
        switch index {
        case 0:
            incompleteListImageView.image = TabBarIconStyleKit.imageOfIncompleteListIconSelected
            currentTabSelection = .incomplete
            
        case 1:
            completeListImageView.image = TabBarIconStyleKit.imageOfCompleteListIconSelected
            currentTabSelection = .complete
            
        default:
            break
        }
    }
    
    func didTapButton(sender: UIButton) {
        
        selectIndex(index: sender.tag)
        
        delegate?.tabBarButtonTapped(index: sender.tag)
    }
    
    
    
}

protocol CustomTabBarDelegate: class {
    func tabBarButtonTapped(index: Int)
    func segue(notNeededMaybe: String)
}
