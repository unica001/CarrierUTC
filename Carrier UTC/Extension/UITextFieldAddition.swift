//
//  UITextFieldAddition.swift
//  Library
//
//  Created by Shilpa Sharma on 19/11/18.
//  Copyright © 2018 Shilpa Sharma. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func addSpacingWithFrame(frame : CGRect, side : NSTextAlignment) -> UITextField {
        
        let paddingView : UIView = UIView (frame : frame)
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.always
        return self
    }
    
    
    func addToolbarWithButtonTitled(title: String, forTarget: UIViewController, selector: Selector)
    {
        let flexibleSpaceLeft = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem.init(title: title, style: .done, target:forTarget, action: selector)
        
        doneButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], for: .normal)
        
        let toolbar = UIToolbar.init(frame: CGRect(x: 0,y: 0,width: Constant.kAppDelegate.window!.frame.size.width,height: 40.0))
        
        toolbar.setItems([flexibleSpaceLeft, doneButton], animated: false)
        
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    class func setLeftPadding(arrayTxt:NSArray, margin:CGFloat)
    {
        for i in 0..<arrayTxt.count
        {
            let txtField = arrayTxt[i] as! UITextField
            
            let viewLeft = UIView.init(frame: CGRect(x: 0,y: 0,width: margin,height: txtField.frame.size.height))
            txtField.leftView = viewLeft
            txtField.leftViewMode = UITextFieldViewMode.always
        }
    }
}

extension UITextView {
    
    func addToolbarWithButtonTitled(title: String, forTarget: Any?, selector: Selector)
    {
        let flexibleSpaceLeft = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem.init(title: title, style: .done, target:forTarget, action: selector)
        
        doneButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], for: .normal)
        
        
        let toolbar = UIToolbar.init(frame: CGRect(x: 0,y: 0,width: Constant.kAppDelegate.window!.frame.size.width,height: 40.0))
        
        toolbar.setItems([flexibleSpaceLeft, doneButton], animated: false)
        
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
}

