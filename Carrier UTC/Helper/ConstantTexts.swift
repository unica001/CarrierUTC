//
//  ConstantTexts.swift
//  Library
//
//  Created by Shilpa Sharma on 19/11/18.
//  Copyright © 2018 Shilpa Sharma. All rights reserved.
//

import Foundation

let kUserDefault  =  UserDefaults.standard

// Segue Identifier

let kairQualitySegueIdentifier = "airQualitySegueIdentifier"

enum ConstantTexts: String {
    
    case appName = "Test"
    case ok = "Ok"
    case cancel = "Cancel"
    
    // Mark- Localized Value
    var localizedString:String {
        return NSLocalizedString(self.rawValue, comment: "")
    }

}
