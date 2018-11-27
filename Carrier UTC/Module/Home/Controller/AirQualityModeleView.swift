//
//  AirQualityViewModole.swift
//  Carrier UTC
//
//  Created by Ram Niwas on 22/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

protocol AirQualityModelling {
    
    func getAirQualityDetails(pmType: String, userListHandler: @escaping (_ responseData: [AirQualityModele], _ success: Bool, _ message: String)-> Void)
    
}

class AirQualityModeleView : AirQualityModelling {
 
    
    func getAirQualityDetails(pmType: String, userListHandler: @escaping (_ responseData: [AirQualityModele], _ success: Bool, _ message: String)-> Void){
        
        let requestURL = URL(string: String(format: "%@%@",kBaseUrl,kair_quality))!
        
        let param : NSMutableDictionary = ["pm_type": pmType]
        
        NetworkManager.sharedInstance.postRequest(requestURL, hude: true, showSystemError: false, loadingText: false, params: param , completionHandler:{(dict) in
            
            print(dict)
            let status : String = String(format:"%@", dict[kstatus]! as! CVarArg)
            
            if status == "200" {
                if let payload = dict.value(forKey: kpayload) as? [String : Any] {
                    let list = payload["event_list"] as? [[String : Any]]
                    let userList = Mapper<AirQualityModele>().mapArray(JSONArray: list!)
                    userListHandler(userList, true, "")
                }
            } else {
                let message = dict[kmessage] as? String
                userListHandler([], true, message!)
            }
        })
    }
}
