//
//  UIButtonAddition.swift
//  Library
//
//  Created by Shilpa Sharma on 19/11/18.
//  Copyright © 2018 Shilpa Sharma. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setTextWith(title: String, font: UIFont, fgColor: UIColor, isUnderLined: Bool = false) {
        var attributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : font,
            NSAttributedString.Key.foregroundColor : fgColor]
        if isUnderLined {
            attributes[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        let attText = NSMutableAttributedString(string: title, attributes: attributes)
        self.setAttributedTitle(attText, for: .normal)
    }
}

