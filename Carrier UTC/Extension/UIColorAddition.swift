//
//  UIColorAddition.swift
//  Library
//
//  Created by Shilpa Sharma on 19/11/18.
//  Copyright © 2018 Shilpa Sharma. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var backgroundColor: UIColor {
        return  UIColor(red: 100.0/255.0, green: 188.0/255.0, blue: 187.0/255.0, alpha: 1.0)
    }
    
    
    // MARK: UIColor additional properties
    class func colorWith(hexString:String)->UIColor {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.utf16.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func colorWithRGBA(redC:CGFloat, greenC:CGFloat, blueC:CGFloat, alfa:CGFloat) -> UIColor {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = alfa
        red   = CGFloat(redC/255.0)
        green = CGFloat(greenC/255.0)
        blue  = CGFloat(blueC/255.0)
        alpha  = CGFloat(alpha)
        let color: UIColor =  UIColor(red:CGFloat(red), green: CGFloat(green), blue:CGFloat(blue), alpha: alpha)
        return color
    }
    
    class func colorWithAlpha(color:CGFloat, alfa:CGFloat) -> UIColor {
        let red:   CGFloat = CGFloat(color / 255.0)
        let green: CGFloat = CGFloat(color / 255.0)
        let blue:  CGFloat = CGFloat(color / 255.0)
        let alpha: CGFloat = alfa
        let color: UIColor =  UIColor(red:red, green:green, blue:blue, alpha:alpha)
        return color
    }
}
