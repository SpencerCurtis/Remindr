//
//  CustomTabBarStyleKit.swift
//  Remindr
//
//  Created by Spencer Curtis on 2/3/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//



import UIKit

public class CustomTabBarStyleKit : NSObject {

    //// Drawing Methods

    public dynamic class func drawCustomTabBar(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 375, height: 49), resizing: ResizingBehavior = .AspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        CGContextSaveGState(context)
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 375, height: 49), target: targetFrame)
        CGContextTranslateCTM(context, resizedFrame.minX, resizedFrame.minY)
        CGContextScaleCTM(context, resizedFrame.width / 375, resizedFrame.height / 49)


        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 374.97, y: -0))
        bezierPath.addCurveToPoint(CGPoint(x: 375, y: 49), controlPoint1: CGPoint(x: 375, y: 0), controlPoint2: CGPoint(x: 375, y: 49))
        bezierPath.addLineToPoint(CGPoint(x: 0, y: 49))
        bezierPath.addLineToPoint(CGPoint(x: 0, y: 0))
        bezierPath.addCurveToPoint(CGPoint(x: 124, y: 7), controlPoint1: CGPoint(x: 0, y: 0), controlPoint2: CGPoint(x: 72.46, y: -0.06))
        bezierPath.addCurveToPoint(CGPoint(x: 187.5, y: 24), controlPoint1: CGPoint(x: 153.69, y: 11.07), controlPoint2: CGPoint(x: 153.62, y: 23.87))
        bezierPath.addCurveToPoint(CGPoint(x: 251, y: 7), controlPoint1: CGPoint(x: 221.38, y: 23.87), controlPoint2: CGPoint(x: 221.31, y: 11.07))
        bezierPath.addCurveToPoint(CGPoint(x: 375, y: 0), controlPoint1: CGPoint(x: 302.54, y: -0.06), controlPoint2: CGPoint(x: 375, y: 0))
        bezierPath.addLineToPoint(CGPoint(x: 374.97, y: -0))
        bezierPath.closePath()
        UIColor.grayColor().setFill()
        bezierPath.fill()
        
        CGContextRestoreGState(context)

    }




    @objc public enum ResizingBehavior: Int {
        case AspectFit /// The content is proportionally resized to fit into the target rectangle.
        case AspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case Stretch /// The content is stretched to match the entire target rectangle.
        case Center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .AspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .AspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .Stretch:
                    break
                case .Center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}