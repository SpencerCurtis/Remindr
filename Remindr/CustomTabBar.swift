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
    
    var newRemindrButtonUnselected = UIButton()
    var newRemindrButtonSelected = UIButton()
    
    var newRemindrButtonIsSelected = false
    var newRemindrButtonIsAnimating = false
    
    enum TabSelection {
        case incomplete
        case complete
    }
    
    var currentTabSelection: TabSelection = .incomplete
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        incompleteListButton.tag = 0
        completeListButton.tag = 1
        
        NotificationCenter.default.addObserver(self, selector: #selector(transitionNewRemindrButtonToUnselectedButton), name: cancelNewRemindrNotification, object: nil)
        
        self.completeListButton.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchDown)
        self.incompleteListButton.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchDown)
        self.backgroundColor = .clear
        setupBarItems()
        setupConstraints {
            NotificationCenter.default.post(name: addNewRemindrButtonNotification, object: nil, userInfo: ["button": newRemindrButtonUnselected])
        }
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
        
        newRemindrButtonUnselected.setImage(TabBarIconStyleKit.imageOfMiddleTabBarButtonUnselected, for: .normal)
        newRemindrButtonSelected.setImage(TabBarIconStyleKit.imageOfMiddleTabBarButtonSelected, for: .normal)
        if currentTabSelection == .incomplete {
            incompleteListImageView.image = TabBarIconStyleKit.imageOfIncompleteListIconSelected
            completeListImageView.image = TabBarIconStyleKit.imageOfCompleteListIconUnselected
        } else {
            incompleteListImageView.image = TabBarIconStyleKit.imageOfIncompleteListIconUnselected
            completeListImageView.image = TabBarIconStyleKit.imageOfCompleteListIconSelected
        }
        
        
    }
    
    func setupBarItems() {
        
        // Incomplete List
        incompleteListImageView.contentMode = .scaleAspectFit
        self.addSubview(incompleteListImageView)
        self.addSubview(incompleteListButton)
        
        // Complete List
        completeListImageView.contentMode = .scaleAspectFit
        self.addSubview(completeListImageView)
        self.addSubview(completeListButton)
        
        // New Remindr Button - Selected (Red cancel button)
        newRemindrButtonSelected.setImage(TabBarIconStyleKit.imageOfMiddleTabBarButtonSelected, for: .normal)
        newRemindrButtonSelected.addTarget(self, action: #selector(transitionNewRemindrButtonToUnselectedButton), for: .touchDown)
        newRemindrButtonSelected.adjustsImageWhenHighlighted = false
        self.addSubview(newRemindrButtonSelected)
        
        // New Remindr Button - Unselected (Blue)
        newRemindrButtonUnselected.setImage(TabBarIconStyleKit.imageOfMiddleTabBarButtonUnselected, for: .normal)
        newRemindrButtonUnselected.addTarget(self, action: #selector(transitionNewRemindrButtonToCancelButton), for: .touchDown)
        newRemindrButtonUnselected.adjustsImageWhenHighlighted = false
        self.addSubview(newRemindrButtonUnselected)
        
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
    
    func transitionNewRemindrButtonToCancelButton() {
        
        newRemindrButtonIsAnimating = true
        
        delegate?.addNewRemindrButtonSelected()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: .curveEaseInOut, animations: {
            self.newRemindrButtonUnselected.transform = CGAffineTransform(rotationAngle: self.degreesToRadians(degrees: 45))
            self.newRemindrButtonSelected.transform = CGAffineTransform(rotationAngle: self.degreesToRadians(degrees: 45))
            self.newRemindrButtonUnselected.alpha = 0
        }) { (_) in
            self.bringSubview(toFront: self.newRemindrButtonSelected)
            self.newRemindrButtonIsSelected = true
            self.newRemindrButtonIsAnimating = false
            
        }
    }
    
    func transitionNewRemindrButtonToUnselectedButton() {
        
        newRemindrButtonIsAnimating = true
        
        delegate?.addNewRemindrButtonDeselected()
        
        self.bringSubview(toFront: newRemindrButtonUnselected)
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: .curveEaseInOut, animations: {
            self.newRemindrButtonUnselected.transform = CGAffineTransform(rotationAngle: self.degreesToRadians(degrees: 0))
            self.newRemindrButtonSelected.transform = CGAffineTransform(rotationAngle: self.degreesToRadians(degrees: 0))
            self.newRemindrButtonUnselected.alpha = 1
        }) { (_) in
            
            self.newRemindrButtonIsSelected = false
            self.newRemindrButtonIsAnimating = false
            
        }
    }
    
    
    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return degrees * CGFloat(M_PI) / 180
    }
    
    func radiansToDegress(radians: CGFloat) -> CGFloat {
        return radians * 180 / CGFloat(M_PI)
    }
}

protocol CustomTabBarDelegate: class {
    func tabBarButtonTapped(index: Int)
    func addNewRemindrButtonSelected()
    func addNewRemindrButtonDeselected()
}

// MARK: - Constraints

extension CustomTabBar {
    
    func setupConstraints(completion: () -> Void) {
        incompleteListImageView.translatesAutoresizingMaskIntoConstraints = false
        incompleteListButton.translatesAutoresizingMaskIntoConstraints = false
        completeListImageView.translatesAutoresizingMaskIntoConstraints = false
        completeListButton.translatesAutoresizingMaskIntoConstraints = false
        newRemindrButtonUnselected.translatesAutoresizingMaskIntoConstraints = false
        newRemindrButtonSelected.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        let newRemindrButtonUnselectedCenterX = NSLayoutConstraint(item: newRemindrButtonUnselected, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let newRemindrButtonUnselectedCenterY = NSLayoutConstraint(item: newRemindrButtonUnselected, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -2)
        let newRemindrButtonUnselectedHeight = NSLayoutConstraint(item: newRemindrButtonUnselected, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 7/8, constant: 0)
        let newRemindrButtonUnselectedWidth = NSLayoutConstraint(item: newRemindrButtonUnselected, attribute: .width, relatedBy: .equal, toItem: newRemindrButtonUnselected, attribute: .height, multiplier: 1, constant: 0)
        
        // If you change the constraints either above or below here, change them to both above and below so they match at all times.
        
        let newRemindrButtonSelectedCenterX = NSLayoutConstraint(item: newRemindrButtonSelected, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let newRemindrButtonSelectedCenterY = NSLayoutConstraint(item: newRemindrButtonSelected, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -2)
        let newRemindrButtonSelectedHeight = NSLayoutConstraint(item: newRemindrButtonSelected, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 7/8, constant: 0)
        let newRemindrButtonSelectedWidth = NSLayoutConstraint(item: newRemindrButtonSelected, attribute: .width, relatedBy: .equal, toItem: newRemindrButtonSelected, attribute: .height, multiplier: 1, constant: 0)
        
        self.addConstraints([incompleteListButtonLeading, incompleteListButtonTop, incompleteListButtonBottom, incompleteListButtonWidth, incompleteListImageViewCenterX, incompleteListImageViewCenterY, incompleteListImageViewHeight, incompleteListImageViewWidth,completeListButtonTrailing, completeListButtonTop, completeListButtonBottom, completeListButtonWidth, completeListImageViewCenterX, completeListImageViewCenterY, completeListImageViewHeight, completeListImageViewWidth, newRemindrButtonUnselectedCenterX, newRemindrButtonUnselectedCenterY, newRemindrButtonUnselectedHeight, newRemindrButtonUnselectedWidth, newRemindrButtonSelectedCenterX, newRemindrButtonSelectedCenterY, newRemindrButtonSelectedHeight, newRemindrButtonSelectedWidth])
        
        completion()
        
    }
}
