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
    
    var titleLabelStrikethroughLayer: CAShapeLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setup() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        
        self.addGestureRecognizer(panRecognizer)
        
        let bezierPath = UIBezierPath()
        let startPoint = CGPoint(x: titleLabel.frame.origin.x, y: titleLabel.center.y)
        
        let endPoint = CGPoint(x: titleLabel.frame.size.width, y: titleLabel.center.y)
        
        bezierPath.move(to: startPoint)
        bezierPath.addLine(to: endPoint)
        
        let layer = CAShapeLayer()
        
        layer.path = bezierPath.cgPath
        layer.strokeColor = UIColor.black.cgColor
        
        layer.strokeStart = 0
        layer.strokeEnd = 0
        
        layer.fillColor = UIColor.clear.cgColor

        titleLabel.layer.addSublayer(layer)
        
        titleLabelStrikethroughLayer = layer

        
    }

    func handlePan(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            break
        case .changed:
            let xTranslation = sender.translation(in: self).x
            
            let percentagePanned = (xTranslation / self.frame.size.width) * 2
            titleLabelStrikethroughLayer.strokeEnd = percentagePanned
        default:
            break
        }
    }
}
