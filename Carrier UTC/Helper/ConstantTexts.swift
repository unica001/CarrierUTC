//
//  ConstantTexts.swift
//  Library
//
//  Created by Shilpa Sharma on 19/11/18.
//  Copyright © 2018 Shilpa Sharma. All rights reserved.
//

import Foundation

let kUserDefault  =  UserDefaults.standard
let kBaseUrl = "http://103.91.90.242:8000/api/"
let kstatus = "status"
let kpayload = "payload"
let kmessage = "message"

//MARK: -  APIs Name
let kair_quality = "air_quality"
let kevents = "events"
let ksearch_event = "search_event"
let kevent_detail = "event_detail"
let kinterested_event = "interested_event"

//MARK: - Segue Identifier
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
