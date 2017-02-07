//
//  TabBarIconStyleKit.swift
//  Remindr
//
//  Created by Spencer Curtis on 2/3/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//



import UIKit

public class TabBarIconStyleKit : NSObject {

    //// Cache

    private struct Cache {
        static var imageOfIncompleteListIconUnselected: UIImage?
        static var incompleteListIconUnselectedTargets: [AnyObject]?
        static var imageOfCompleteListIconSelected: UIImage?
        static var completeListIconSelectedTargets: [AnyObject]?
        static var imageOfIncompleteListIconSelected2: UIImage?
        static var incompleteListIconSelected2Targets: [AnyObject]?
        static var imageOfCompleteListIconUnselected: UIImage?
        static var completeListIconUnselectedTargets: [AnyObject]?
    }

    //// Drawing Methods

    public dynamic class func drawIncompleteListIconUnselected(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 150, height: 150), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 150, height: 150), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 150, y: resizedFrame.height / 150)


        //// Color Declarations
        let color2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Page Drawing
        let pagePath = UIBezierPath()
        pagePath.move(to: CGPoint(x: 40, y: 75))
        pagePath.addCurve(to: CGPoint(x: 40, y: 114.2), controlPoint1: CGPoint(x: 40, y: 112.87), controlPoint2: CGPoint(x: 40, y: 114.2))
        pagePath.addCurve(to: CGPoint(x: 49.72, y: 124), controlPoint1: CGPoint(x: 40, y: 114.2), controlPoint2: CGPoint(x: 40, y: 124))
        pagePath.addCurve(to: CGPoint(x: 100.28, y: 124), controlPoint1: CGPoint(x: 59.44, y: 124), controlPoint2: CGPoint(x: 100.28, y: 124))
        pagePath.addCurve(to: CGPoint(x: 110, y: 114.2), controlPoint1: CGPoint(x: 100.28, y: 124), controlPoint2: CGPoint(x: 110, y: 124))
        pagePath.addCurve(to: CGPoint(x: 110, y: 75), controlPoint1: CGPoint(x: 110, y: 109.45), controlPoint2: CGPoint(x: 110, y: 91.92))
        pagePath.move(to: CGPoint(x: 110, y: 75))
        pagePath.addCurve(to: CGPoint(x: 110, y: 35.8), controlPoint1: CGPoint(x: 110, y: 37.13), controlPoint2: CGPoint(x: 110, y: 35.8))
        pagePath.addCurve(to: CGPoint(x: 100.28, y: 26), controlPoint1: CGPoint(x: 110, y: 35.8), controlPoint2: CGPoint(x: 110, y: 26))
        pagePath.addCurve(to: CGPoint(x: 49.72, y: 26), controlPoint1: CGPoint(x: 90.56, y: 26), controlPoint2: CGPoint(x: 49.72, y: 26))
        pagePath.addCurve(to: CGPoint(x: 40, y: 35.8), controlPoint1: CGPoint(x: 49.72, y: 26), controlPoint2: CGPoint(x: 40, y: 26))
        pagePath.addCurve(to: CGPoint(x: 40, y: 75), controlPoint1: CGPoint(x: 40, y: 40.55), controlPoint2: CGPoint(x: 40, y: 58.08))
        color2.setStroke()
        pagePath.lineWidth = 2
        pagePath.stroke()


        //// Page Lines


        //// Group
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 59, y: 36, width: 46, height: 20), cornerRadius: 3)
        UIColor.white.setFill()
        rectanglePath.fill()


        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 43.5, y: 39.5, width: 13, height: 13))
        UIColor.white.setStroke()
        ovalPath.lineWidth = 2
        ovalPath.stroke()




        //// Group 2
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(roundedRect: CGRect(x: 59, y: 65.5, width: 46, height: 20), cornerRadius: 3)
        UIColor.white.setFill()
        rectangle2Path.fill()


        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalIn: CGRect(x: 43.5, y: 69, width: 13, height: 13))
        UIColor.white.setStroke()
        oval2Path.lineWidth = 2
        oval2Path.stroke()




        //// Group 3
        //// Rectangle 3 Drawing
        let rectangle3Path = UIBezierPath(roundedRect: CGRect(x: 59, y: 96, width: 46, height: 20), cornerRadius: 3)
        UIColor.white.setFill()
        rectangle3Path.fill()


        //// Oval 3 Drawing
        let oval3Path = UIBezierPath(ovalIn: CGRect(x: 43.5, y: 99.5, width: 13, height: 13))
        UIColor.white.setStroke()
        oval3Path.lineWidth = 2
        oval3Path.stroke()
        
        context.restoreGState()

    }

    public dynamic class func drawCompleteListIconSelected(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 150, height: 150), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 150, height: 150), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 150, y: resizedFrame.height / 150)


        //// Color Declarations
        let color3 = UIColor(red: 0.310, green: 0.800, blue: 0.969, alpha: 1.000)
        let color5 = UIColor(red: 0.502, green: 0.502, blue: 0.502, alpha: 1.000)

        //// Oval 4 Drawing
        let oval4Path = UIBezierPath(ovalIn: CGRect(x: 0, y: 1, width: 149, height: 149))
        color3.setFill()
        oval4Path.fill()


        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 21, y: 22, width: 107, height: 107))
        color5.setFill()
        ovalPath.fill()


        //// Group
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: 29.91, y: 74.27))
        bezier4Path.addLine(to: CGPoint(x: 65.25, y: 112.84))
        bezier4Path.addLine(to: CGPoint(x: 144.89, y: 19.16))
        bezier4Path.addLine(to: CGPoint(x: 138.88, y: 13.52))
        bezier4Path.addLine(to: CGPoint(x: 65.25, y: 98.78))
        bezier4Path.addLine(to: CGPoint(x: 36.72, y: 67.46))
        bezier4Path.addLine(to: CGPoint(x: 29.91, y: 74.27))
        bezier4Path.close()
        color3.setFill()
        bezier4Path.fill()
        
        context.restoreGState()

    }

    public dynamic class func drawIncompleteListIconSelected2(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 150, height: 150), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 150, height: 150), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 150, y: resizedFrame.height / 150)


        //// Color Declarations
        let color2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let color3 = UIColor(red: 0.310, green: 0.800, blue: 0.969, alpha: 1.000)

        //// Oval 4 Drawing
        let oval4Path = UIBezierPath(ovalIn: CGRect(x: 0, y: 1, width: 149, height: 149))
        color3.setFill()
        oval4Path.fill()


        //// Page Drawing
        let pagePath = UIBezierPath()
        pagePath.move(to: CGPoint(x: 40, y: 75))
        pagePath.addCurve(to: CGPoint(x: 40, y: 114.2), controlPoint1: CGPoint(x: 40, y: 112.87), controlPoint2: CGPoint(x: 40, y: 114.2))
        pagePath.addCurve(to: CGPoint(x: 49.72, y: 124), controlPoint1: CGPoint(x: 40, y: 114.2), controlPoint2: CGPoint(x: 40, y: 124))
        pagePath.addCurve(to: CGPoint(x: 100.28, y: 124), controlPoint1: CGPoint(x: 59.44, y: 124), controlPoint2: CGPoint(x: 100.28, y: 124))
        pagePath.addCurve(to: CGPoint(x: 110, y: 114.2), controlPoint1: CGPoint(x: 100.28, y: 124), controlPoint2: CGPoint(x: 110, y: 124))
        pagePath.addCurve(to: CGPoint(x: 110, y: 75), controlPoint1: CGPoint(x: 110, y: 109.45), controlPoint2: CGPoint(x: 110, y: 91.92))
        pagePath.move(to: CGPoint(x: 110, y: 75))
        pagePath.addCurve(to: CGPoint(x: 110, y: 35.8), controlPoint1: CGPoint(x: 110, y: 37.13), controlPoint2: CGPoint(x: 110, y: 35.8))
        pagePath.addCurve(to: CGPoint(x: 100.28, y: 26), controlPoint1: CGPoint(x: 110, y: 35.8), controlPoint2: CGPoint(x: 110, y: 26))
        pagePath.addCurve(to: CGPoint(x: 49.72, y: 26), controlPoint1: CGPoint(x: 90.56, y: 26), controlPoint2: CGPoint(x: 49.72, y: 26))
        pagePath.addCurve(to: CGPoint(x: 40, y: 35.8), controlPoint1: CGPoint(x: 49.72, y: 26), controlPoint2: CGPoint(x: 40, y: 26))
        pagePath.addCurve(to: CGPoint(x: 40, y: 75), controlPoint1: CGPoint(x: 40, y: 40.55), controlPoint2: CGPoint(x: 40, y: 58.08))
        color2.setStroke()
        pagePath.lineWidth = 2
        pagePath.stroke()


        //// Page Lines


        //// Group
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 59, y: 36, width: 46, height: 20), cornerRadius: 3)
        UIColor.white.setFill()
        rectanglePath.fill()


        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 43.5, y: 39.5, width: 13, height: 13))
        UIColor.white.setStroke()
        ovalPath.lineWidth = 2
        ovalPath.stroke()




        //// Group 2
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(roundedRect: CGRect(x: 59, y: 65.5, width: 46, height: 20), cornerRadius: 3)
        UIColor.white.setFill()
        rectangle2Path.fill()


        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalIn: CGRect(x: 43.5, y: 69, width: 13, height: 13))
        UIColor.white.setStroke()
        oval2Path.lineWidth = 2
        oval2Path.stroke()




        //// Group 3
        //// Rectangle 3 Drawing
        let rectangle3Path = UIBezierPath(roundedRect: CGRect(x: 59, y: 96, width: 46, height: 20), cornerRadius: 3)
        UIColor.white.setFill()
        rectangle3Path.fill()


        //// Oval 3 Drawing
        let oval3Path = UIBezierPath(ovalIn: CGRect(x: 43.5, y: 99.5, width: 13, height: 13))
        UIColor.white.setStroke()
        oval3Path.lineWidth = 2
        oval3Path.stroke()
        
        context.restoreGState()

    }

    public dynamic class func drawCompleteListIconUnselected(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 150, height: 150), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 150, height: 150), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 150, y: resizedFrame.height / 150)


        //// Color Declarations
        let color3 = UIColor(red: 0.310, green: 0.800, blue: 0.969, alpha: 1.000)
        let color5 = UIColor(red: 0.502, green: 0.502, blue: 0.502, alpha: 1.000)

        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 21, y: 22, width: 107, height: 107))
        color5.setFill()
        ovalPath.fill()


        //// Group
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: 29.91, y: 74.27))
        bezier4Path.addLine(to: CGPoint(x: 65.25, y: 112.84))
        bezier4Path.addLine(to: CGPoint(x: 144.89, y: 19.16))
        bezier4Path.addLine(to: CGPoint(x: 138.88, y: 13.52))
        bezier4Path.addLine(to: CGPoint(x: 65.25, y: 98.78))
        bezier4Path.addLine(to: CGPoint(x: 36.72, y: 67.46))
        bezier4Path.addLine(to: CGPoint(x: 29.91, y: 74.27))
        bezier4Path.close()
        color3.setFill()
        bezier4Path.fill()
        
        context.restoreGState()

    }

    //// Generated Images

    public dynamic class var imageOfIncompleteListIconUnselected: UIImage {
        if Cache.imageOfIncompleteListIconUnselected != nil {
            return Cache.imageOfIncompleteListIconUnselected!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 150, height: 150), false, 0)
            TabBarIconStyleKit.drawIncompleteListIconUnselected()

        Cache.imageOfIncompleteListIconUnselected = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfIncompleteListIconUnselected!
    }

    public dynamic class var imageOfCompleteListIconSelected: UIImage {
        if Cache.imageOfCompleteListIconSelected != nil {
            return Cache.imageOfCompleteListIconSelected!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 150, height: 150), false, 0)
            TabBarIconStyleKit.drawCompleteListIconSelected()

        Cache.imageOfCompleteListIconSelected = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfCompleteListIconSelected!
    }

    public dynamic class var imageOfIncompleteListIconSelected2: UIImage {
        if Cache.imageOfIncompleteListIconSelected2 != nil {
            return Cache.imageOfIncompleteListIconSelected2!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 150, height: 150), false, 0)
            TabBarIconStyleKit.drawIncompleteListIconSelected2()

        Cache.imageOfIncompleteListIconSelected2 = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfIncompleteListIconSelected2!
    }

    public dynamic class var imageOfCompleteListIconUnselected: UIImage {
        if Cache.imageOfCompleteListIconUnselected != nil {
            return Cache.imageOfCompleteListIconUnselected!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 150, height: 150), false, 0)
            TabBarIconStyleKit.drawCompleteListIconUnselected()

        Cache.imageOfCompleteListIconUnselected = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfCompleteListIconUnselected!
    }

    //// Customization Infrastructure

    @IBOutlet dynamic var incompleteListIconUnselectedTargets: [AnyObject]! {
        get { return Cache.incompleteListIconUnselectedTargets }
        set {
            Cache.incompleteListIconUnselectedTargets = newValue
            for target: AnyObject in newValue {
                let _ = target.perform(NSSelectorFromString("setImage:"), with: TabBarIconStyleKit.imageOfIncompleteListIconUnselected)
            }
        }
    }

    @IBOutlet dynamic var completeListIconSelectedTargets: [AnyObject]! {
        get { return Cache.completeListIconSelectedTargets }
        set {
            Cache.completeListIconSelectedTargets = newValue
            for target: AnyObject in newValue {
                let _ = target.perform(NSSelectorFromString("setImage:"), with: TabBarIconStyleKit.imageOfCompleteListIconSelected)
            }
        }
    }

    @IBOutlet dynamic var incompleteListIconSelected2Targets: [AnyObject]! {
        get { return Cache.incompleteListIconSelected2Targets }
        set {
            Cache.incompleteListIconSelected2Targets = newValue
            for target: AnyObject in newValue {
                let _ = target.perform(NSSelectorFromString("setImage:"), with: TabBarIconStyleKit.imageOfIncompleteListIconSelected2)
            }
        }
    }

    @IBOutlet dynamic var completeListIconUnselectedTargets: [AnyObject]! {
        get { return Cache.completeListIconUnselectedTargets }
        set {
            Cache.completeListIconUnselectedTargets = newValue
            for target: AnyObject in newValue {
                let _ = target.perform(NSSelectorFromString("setImage:"), with: TabBarIconStyleKit.imageOfCompleteListIconUnselected)
            }
        }
    }




    @objc public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
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
