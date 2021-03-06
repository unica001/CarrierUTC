//
//  Helper.swift
//  Library
//
//  Created by Shilpa Sharma on 19/11/18.
//  Copyright © 2018 Shilpa Sharma. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookShare

private let kInstagramURL = "instagram://"
private let kUTI = "com.instagram.exclusivegram"
private let kfileNameExtension = "instagram.igo"
private let kAlertViewTitle = "Error"
private let kAlertViewMessage = "Please install the Instagram application"

private let documentInteractionController = UIDocumentInteractionController()

class Helper {
    
    
    func getDateFromTimeStamp(timeStamp : Double) -> Date {
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        
        return dayTimePeriodFormatter.date(from: dateString)!
    }
    
    //MARK: - Calculate height and width with string
    func calculateHeightForString(_ inString:String,_width :CGFloat) -> CGFloat
    {
        let messageString = inString
        let attrString:NSAttributedString? = NSAttributedString(string: messageString, attributes: nil)
        let rect:CGRect = attrString!.boundingRect(with: CGSize(width: _width,height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, context:nil )//hear u will get nearer height not the exact value
        let requredSize:CGRect = rect
        return requredSize.height  //to include button's in your tableview
    }
    
    func calculateHeightForlblText(_ inString:String,  _width :CGFloat) -> CGFloat
    {
        let constraintRect = CGSize(width: _width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = inString.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [ NSAttributedString.Key.font: UIFont(name: FontFamily.Montserrat.rawValue, size: 14.2)! ], context: nil)
        
        return boundingBox.height
    }
    
    // MARK: - Get root view controller
    class func rootViewController() -> UIViewController {
        return (UIApplication.shared.keyWindow?.rootViewController)!
    }
    
    // MARK: - Get topmost view controller
    class func topMostViewController(rootViewController: UIViewController) -> UIViewController? {
        if let navigationController = rootViewController as? UINavigationController {
            return topMostViewController(rootViewController: navigationController.visibleViewController!)
        }
        if let tabBarController = rootViewController as? UITabBarController {
            if let selectedTabBarController = tabBarController.selectedViewController {
                return topMostViewController(rootViewController: selectedTabBarController)
            }
        }
        if let presentedViewController = rootViewController.presentedViewController {
            return topMostViewController(rootViewController: presentedViewController)
        }
        return rootViewController
    }
    
    //MARK: - Get Visible view controller
    class func visibleController() -> UIViewController {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return UIViewController()
    }
    
    class func getIndexPathFor(view: UIView, tableView: UITableView) -> IndexPath? {
        let point = tableView.convert(view.bounds.origin, from: view)
        let indexPath = tableView.indexPathForRow(at: point)
        return indexPath
    }
    
    class func stringToDate(strDate: String, format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: strDate)!
    }
    
    //MARK: - Convert data to json string
    class public func toJsonString(from object: Any) -> String? {
        if let objectData = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions(rawValue: 0)) {
            let objectString = String(data: objectData, encoding: .utf8)
            return objectString
        }
        return nil
    }
    
    class func getFileSize(url: URL) -> Double {
        do {
            let attribute = try FileManager.default.attributesOfItem(atPath: url.path)
            if let size = attribute[FileAttributeKey.size] as? NSNumber {
                return size.doubleValue / (Constant.byte1024 * Constant.byte1024)
            }
        } catch {
            print("Error: \(error)")
        }
        return 0.0
    }
    
    //MARK: - Validation
    class func isValidEmail(emailString:String, strictFilter:Bool) -> Bool {
        let strictEmailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let laxString = ".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        let emailRegex = strictFilter ? strictEmailRegEx : laxString
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: emailString)
    }
    
    func checkSpecialCharacter(string : String)-> Bool {
        var isSpecialCharacter = false
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        if string.rangeOfCharacter(from: characterset.inverted) != nil {
            isSpecialCharacter = true
        }
        return isSpecialCharacter
    }
    
    
    //MARK: Archive And Unarchive
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func shareToInstagram(imageInstagram: UIImage, contentShare: String, view: UIView) {
        let instagramURL = NSURL(string: kInstagramURL)
        if UIApplication.shared.canOpenURL(instagramURL! as URL) {
            
            let jpgPath = NSTemporaryDirectory().appending(kfileNameExtension)
            do {
                if let pngImageData = imageInstagram.jpegData(compressionQuality: 1.0) {
                    try pngImageData.write(to: URL(fileURLWithPath: jpgPath), options: .atomic)
                } } catch { }
            
            let rect = CGRect.zero
            let fileURL = NSURL.fileURL(withPath: jpgPath)
            documentInteractionController.url = fileURL
//            documentInteractionController.delegate = self
            documentInteractionController.uti = kUTI
            
            // adding caption for the image
            documentInteractionController.annotation = ["InstagramCaption": contentShare]
            documentInteractionController.presentOpenInMenu(from: rect, in: view, animated: true)
        }
        else {
            Alert.showOkAlert(title: kAlertViewTitle, message: kAlertViewMessage)
        }
    }
    
    class func shareToFacebook(image: String, content: String) {
        let content = LinkShareContent(url: URL(string: image)!, quote: content)
        
        let dialog = ShareDialog(content: content)
//        dialog.presentingViewController = self
        dialog.mode = .automatic
        dialog.completion = { result in
            
        }
        try? dialog.show()
    }
}
