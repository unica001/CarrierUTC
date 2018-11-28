//
//  UIViewAddition.swift
//  Library
//
//  Created by Shilpa Sharma on 19/11/18.
//  Copyright © 2018 Shilpa Sharma. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBorder(withRadius radius: CGFloat, color: CGColor) {
        let layer = self.layer
        layer.masksToBounds = true
        layer.borderWidth = radius
        layer.borderColor = color
    }
    
    func addBorderWithShadow(withRadius radius: CGFloat, color: CGColor) {
        let layer = self.layer
        layer.masksToBounds = true
        layer.borderColor = color
        layer.borderWidth = radius
        layer.shadowOpacity = 0.50
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 1
    }
    
    func insertShadow(shadowRadius: CGFloat, width: CGFloat, height: CGFloat, shadowColor: CGColor, masksToBounds: Bool = true) {
        layer.masksToBounds = masksToBounds
        layer.shadowColor = shadowColor
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = shadowRadius
    }
    
    func makeLayer(color: UIColor, boarderWidth: CGFloat, round:CGFloat) -> Void {
        self.layer.borderWidth = boarderWidth;
        self.layer.cornerRadius = round;
        self.layer.masksToBounds =  true;
        self.layer.borderColor = color.cgColor
    }
    
    func roundCorners(borderWidth: CGFloat,borderColor: CGColor, cornerRadius: CGFloat) {
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func addShadowInHeader() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height:5)
    }
    
}
