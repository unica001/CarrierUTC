//
//  HistoryVM.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 28/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

protocol HistoryViewModelling {
    func getHistory(historyHandler: @escaping (HistoryModel, Bool, String) -> Void)
}

class HistoryVM: HistoryViewModelling {
    func getHistory(historyHandler: @escaping (HistoryModel, Bool, String) -> Void) {
        let requestURL = URL(string: String(format: "%@%@",kBaseUrl,kweek_air_pollution))!
        
        let param : NSMutableDictionary = [:]
        param["location"] = ""
        if Constant.kAppDelegate.appLocation != nil {
            param["location"] = Constant.kAppDelegate.appLocation.id
        }
        
        NetworkManager.sharedInstance.postRequest(requestURL, hude: true, showSystemError: false, loadingText: false, params: param , completionHandler:{(dict) in
            
            print(dict)
            let status : String = String(format:"%@", dict[kstatus]! as! CVarArg)
            if status == "200" {
                if let payload = dict.value(forKey: kpayload) as? [String : Any] {
                    let history = Mapper<HistoryModel>().map(JSON: payload)
                    historyHandler(history!, true, "")
                }
            } else {
                let message = dict[kmessage] as? String
//                historyHandler([:], false, message!)
            }
        })
    }
}
