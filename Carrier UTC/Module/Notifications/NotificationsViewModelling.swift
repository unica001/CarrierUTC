//
//  NotificationsViewModelling.swift
//  Carrier UTC
//
//  Created by Ram Niwas on 27/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

protocol NotificationModel {
   func sendDeviceTokenOnServer (lat: String,lng:String, deviceToken:String,handler : @escaping (_ message : String,_ sucess : Bool)-> Void)
}

class notificationsViewModelling : NotificationModel{
    
    func sendDeviceTokenOnServer (lat: String,lng:String, deviceToken:String,handler : @escaping (_ message : String,_ sucess : Bool)-> Void){
        
        let requestURL = URL(string: String(format: "%@%@",kBaseUrl,knotification))!
        
        let param : NSMutableDictionary = [:]
        param["lat"] = lat
        param["lon"] = lng
        param["device_id"] = deviceToken
        param["device_type"] = "iOS"

        
        NetworkManager.sharedInstance.postRequest(requestURL, hude: true, showSystemError: false, loadingText: false, params: param , completionHandler:{(dict) in
            
            print(dict)
            let status : String = String(format:"%@", dict[kstatus]! as! CVarArg)
            
            if status == "200" {
                if (dict.value(forKey: kpayload) as? [String : Any]) != nil {
                    let message = dict[kmessage] as? String
                    print(message!)
                }
            } else {
                let message = dict[kmessage] as? String
                print(message!)
            }
        })

  
}
}
