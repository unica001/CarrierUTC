//
//  Alert.swift
//  Library
//
//  Created by Shilpa Sharma on 19/11/18.
//  Copyright © 2018 Shilpa Sharma. All rights reserved.
//

import UIKit

class Alert {
    
    // MARK: Alert methods
    class func Alert(_ message: String, okButtonTitle: String? = nil, target: UIViewController? = nil) {
        
        //BZBanner.showMessage(nil, message: message)
    }
    
    class func showOkAlert(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        if let viewC = Constant.kAppDelegate.window?.rootViewController {
            viewC.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func showOkAlertWithCallBack(title: String, message: String ,completeion_: @escaping (_ compl:Bool)->())
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action:UIAlertAction!) -> Void in
            completeion_(true) //returns true in callback to perform action on last screen
        })
        alertController.addAction(cancelAction)
        if let topViewController: UIViewController = Helper.topMostViewController(rootViewController: Helper.rootViewController()) {
            topViewController.present(alertController, animated: true, completion: nil)
        } else if let viewC = UIApplication.shared.delegate?.window??.rootViewController {
            viewC.present(alertController, animated: true, completion: nil)
        }
        /*
         let topViewController: UIViewController = Helper.topMostViewController(rootViewController: Helper.rootViewController())!
         topViewController.present(alertController, animated: true, completion: nil)
         */
    }
    
    class func showAlert(title: String? = nil, message: String? = nil, style: UIAlertControllerStyle = .alert, actions: UIAlertAction...) {
        
        let topViewController: UIViewController? = Helper.topMostViewController(rootViewController: Helper.rootViewController())
        var strTitle: String = ""
        if let titleStr = title {
            strTitle = titleStr
        } else {
            strTitle = ConstantTexts.appName.localizedString
        }
        let alertController = UIAlertController(title: strTitle, message: message, preferredStyle: style)
        if !actions.isEmpty {
            for action in actions {
                alertController.addAction(action)
            }
        } else {
            let cancelAction = UIAlertAction(title: ConstantTexts.cancel.localizedString, style: .default, handler: nil)
            alertController.addAction(cancelAction)
        }
        topViewController?.present(alertController, animated: true, completion: nil)
    }
    
    class func showAlertWithAction(title: String?, message: String?, style: UIAlertControllerStyle, actionTitles:[String?], action:((UIAlertAction) -> Void)?) {
        
        showAlertWithActionWithCancel(title: title, message: message, style: style, actionTitles: actionTitles, showCancel: false, deleteTitle: nil, action: action)
    }
    
    class func showAlertWithActionWithCancel(title: String?, message: String?, style: UIAlertControllerStyle, actionTitles:[String?], showCancel:Bool, deleteTitle: String? ,_ viewC: UIViewController? = nil, action:((UIAlertAction) -> Void)?) {
        
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        if deleteTitle != nil {
            let deleteAction = UIAlertAction(title: deleteTitle, style: .destructive, handler: action)
            alertController.addAction(deleteAction)
        }
        for (_, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: action)
            alertController.addAction(action)
        }
        
        if showCancel {
            let cancelAction = UIAlertAction(title: ConstantTexts.cancel.localizedString, style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        }
        if let viewController = viewC {
            
            viewController.present(alertController, animated: true, completion: nil)
            
        } else {
            let topViewController: UIViewController? = Helper.topMostViewController(rootViewController: Helper.rootViewController())
            topViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
