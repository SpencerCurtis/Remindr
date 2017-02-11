//
//  IncompleteRemindrTableViewCell.swift
//  Remindr
//
//  Created by Spencer Curtis on 2/8/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//

import UIKit

class IncompleteRemindrTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var originalTitleLabelCenterX: CGFloat = 0
    
    var percentagePanned: CGFloat = 0
    var previousPercentagePanned: CGFloat = 0
    var didSetup = false
    
    var titleLabelStrikethroughLayer: CAShapeLayer!
    var panType: PanType = .none
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup() {
        
        // This bezierPath and CAShapeLayer are the animated strikethrough for the titleLabel when swiping left or right on the cell.
        
        let bezierPath = UIBezierPath()
        let startPoint = CGPoint(x: 0, y: (titleLabel.frame.size.height / 2))
        
        let endPoint = CGPoint(x: titleLabel.intrinsicContentSize.width, y: (titleLabel.frame.size.height / 2))
        
        bezierPath.move(to: startPoint)
        bezierPath.addLine(to: endPoint)
        
        let layer = CAShapeLayer()
        
        layer.path = bezierPath.cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 5
        
        layer.strokeStart = 0
        layer.strokeEnd = 0
        
        layer.fillColor = UIColor.clear.cgColor
        
        titleLabel.layer.addSublayer(layer)
        
        titleLabelStrikethroughLayer = layer
        
        // The titleLabel moves slightly along with the swiping, so this is to be able to reset it to its original center upon cancelling a swipe.
        
        originalTitleLabelCenterX = titleLabel.center.x
        
        
    }
    
    enum PanType {
        case complete
        case delete
        case none
    }
    
    func handlePan(sender: UIPanGestureRecognizer) {
        if !didSetup { setup(); didSetup = true }
        
        switch sender.state {
        case .began:
            self.panType = sender.translation(in: self).x > 0 ? .complete : .delete
            if self.panType == .complete {
                guard titleLabelStrikethroughLayer.strokeStart != 1 && titleLabelStrikethroughLayer.strokeEnd != 1 else {
                    CATransaction.begin()
                    CATransaction.setDisableActions(true)
                    titleLabelStrikethroughLayer.strokeStart = 0
                    titleLabelStrikethroughLayer.strokeEnd = 0
                    CATransaction.commit()
                    return
                }
            } else if panType == .delete {
                guard titleLabelStrikethroughLayer.strokeStart != 0 && titleLabelStrikethroughLayer.strokeEnd != 0 else {
                    CATransaction.begin()
                    CATransaction.setDisableActions(true)
                    titleLabelStrikethroughLayer.strokeStart = 1
                    titleLabelStrikethroughLayer.strokeEnd = 1
                    CATransaction.commit()
                    return
                }
            }
        case .changed:
            let xTranslation = sender.translation(in: self).x
            
            
            self.previousPercentagePanned = percentagePanned
            self.percentagePanned = ((xTranslation / self.frame.size.width) * 2)
            
            if self.percentagePanned > self.previousPercentagePanned {
                titleLabel.center.x += 1
            } else if self.percentagePanned < self.previousPercentagePanned {
                titleLabel.center.x -= 1
            }
            
            if self.panType == .complete {
                
                
                if self.percentagePanned > self.previousPercentagePanned {
                    titleLabelStrikethroughLayer.strokeEnd += 0.05
                } else if self.percentagePanned < self.previousPercentagePanned {
                    titleLabelStrikethroughLayer.strokeEnd -= 0.05
                }
                
                
                if titleLabelStrikethroughLayer.strokeEnd <= 0.8, titleLabelStrikethroughLayer.strokeColor != UIColor.black.cgColor {
                    titleLabelStrikethroughLayer.strokeColor = UIColor.black.cgColor
                } else if titleLabelStrikethroughLayer.strokeEnd > 0.8, titleLabelStrikethroughLayer.strokeColor != UIColor.green.cgColor {
                    titleLabelStrikethroughLayer.strokeColor = UIColor.green.cgColor
                }
                
            } else if self.panType == .delete {
                
                if self.percentagePanned < self.previousPercentagePanned {
                    titleLabelStrikethroughLayer.strokeStart -= 0.05
                } else if self.percentagePanned > self.previousPercentagePanned {
                    titleLabelStrikethroughLayer.strokeStart += 0.05
                }
                
                if titleLabelStrikethroughLayer.strokeStart >= 0.2, titleLabelStrikethroughLayer.strokeColor != UIColor.black.cgColor {
                    titleLabelStrikethroughLayer.strokeColor = UIColor.black.cgColor
                } else if titleLabelStrikethroughLayer.strokeStart < 0.2, titleLabelStrikethroughLayer.strokeColor != UIColor.red.cgColor {
                    titleLabelStrikethroughLayer.strokeColor = UIColor.red.cgColor
                }
            }
            
            
        case .ended:
            
            
            // Have the stroke go back to zero if the strikethrough layer is black (basically, they don't want to complete, nor remove the remindr
            
            if panType == .complete && titleLabelStrikethroughLayer.strokeEnd < 0.8 {
                titleLabelStrikethroughLayer.strokeEnd = 0
                titleLabelStrikethroughLayer.strokeColor = UIColor.black.cgColor
                
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self.titleLabel.center.x = self.originalTitleLabelCenterX
                }, completion: nil)
            } else if panType == .delete && titleLabelStrikethroughLayer.strokeStart > 0.2 {
                titleLabelStrikethroughLayer.strokeStart = 1
                titleLabelStrikethroughLayer.strokeColor = UIColor.black.cgColor
                
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self.titleLabel.center.x = self.originalTitleLabelCenterX
                }, completion: nil)
            } else if panType == .complete && titleLabelStrikethroughLayer.strokeEnd >= 0.8 {
                // (Have another animation? and) run whatever to check the remindr off as completed if the strikethrough layer is green
                
            } else if panType == .delete && titleLabelStrikethroughLayer.strokeStart <= 0.2 {
                // (Have another animation? and) run whatever to delete the remindr if the strikethrough layer is red.
            }
            
            panType = .none
        default:
            break
        }
    }
}
