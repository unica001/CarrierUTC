//
//  UIFontAddition.swift
//  Library
//
//  Created by Shilpa Sharma on 19/11/18.
//  Copyright © 2018 Shilpa Sharma. All rights reserved.
//

import UIKit

enum FontSize: CGFloat {
    case size_8   = 8.0
    case size_10  = 10.0
    case size_11  = 11.0
    case size_12  = 12.0
    case size_13  = 13.0
    case size_14  = 14.0
    case size_15  = 15.0
    case size_16  = 16.0
    case size_17  = 17.0
    case size_19  = 19.0
    case size_20  = 20.0
    case size_21  = 21.0
    case size_22  = 22.0
}

enum FontFamily: String {
    case Montserrat = "Montserrat"
    case ArialMT = "ArialMT"
    case Helvetica = "Helvetica-Neue"
    case OpenSans = "OpenSans"

    
    func fontName(wieight: FontWeight)-> String {
        return rawValue + "-" + wieight.rawValue
    }
}

enum FontWeight: String {
    case Black         = "Black"
    case BlackItalic   = "BlackItalic"
    case Bold          = "Bold"
    case BoldItalic    = "BoldItalic"
    case ExtraBold     = "ExtraBold"
    case ExtraBoldItalic    = "ExtraBoldItalic"
    case ExtraLight    = "ExtraLight"
    case ExtraLightItalic = "ExtraLightItalic"
    case Light         = "Light"
    case Italic        = "Italic"
    case LightItalic   = "LightItalic"
    case Medium        = "Medium"
    case MediumItalic  = "MediumItalic"
    case Regular       = "Regular"
    case SemiBold      = "Semibold"
    case SemiBoldItalic = "SemiBoldItalic"
    case Thin          =  "Thin"
    case ThinItalic    = "ThinItalic"
}

extension UIFont {
    
    class func font(name fontName: FontFamily, weight: FontWeight = .Regular, size: FontSize ) -> UIFont{
        let fontFamily = fontName.fontName(wieight: weight)
        if let font = UIFont(name: fontFamily, size: size.rawValue) {
            return font
        } else {
            print("error while getting font")
            return UIFont.systemFont(ofSize: size.rawValue)
        }
    }
}

