//
//  SearchEventVM.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 22/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit
import ObjectMapper

protocol SearchEventViewModelling {
    func getSearchEvent(pageIndex: Int, searchText: String, searchType: String, searchEventListHandler: @escaping (_ eventResponse: [EventModel], _ totalCount: Int, _ success: Bool, _ message: String)-> Void)
}

class SearchEventVM: SearchEventViewModelling {
    
    func getSearchEvent(pageIndex: Int, searchText: String, searchType: String, searchEventListHandler: @escaping (_ eventResponse: [EventModel], _ totalCount: Int, _ success: Bool, _ message: String)-> Void) {
        let requestURL = URL(string: String(format: "%@%@",kBaseUrl,ksearch_event))!
        
        let param : NSMutableDictionary = ["page_no": pageIndex,
                                           "search_text" : searchText,
                                           "search_type" : searchType]
        
        
        NetworkManager.sharedInstance.postRequest(requestURL, hude: true, showSystemError: false, loadingText: false, params: param , completionHandler:{(dict) in
            
            print(dict)
            let status : String = String(format:"%@", dict[kstatus]! as! CVarArg)
            if status == "200" {
                if let payload = dict.value(forKey: kpayload) as? [String : Any] {
                    let totalCount = payload["total_records"] as? Int
                    let list = payload["events"] as? [[String : Any]]
                    let allEvent = Mapper<EventModel>().mapArray(JSONArray: list!)
                    searchEventListHandler(allEvent,totalCount ?? 0, true, "")
                }
            } else {
                let message = dict[kmessage] as? String
                searchEventListHandler([],0, false, message!)
            }
        })
    }
}
