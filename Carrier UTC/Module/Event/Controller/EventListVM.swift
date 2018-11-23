//
//  EventListVM.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 22/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

protocol EventListViewModelling {
    func getAllEvents(allEventListHandler: @escaping (_ upcomingResponse: [EventModel], _ upcomingEventCount: Int, _ pastResponse: [EventModel], _ pastEventCount: Int,  _ success: Bool, _ message: String)-> Void)
}

class EventListVM: EventListViewModelling {
   
    func getAllEvents(allEventListHandler: @escaping ([EventModel],Int, [EventModel], Int, Bool, String) -> Void) {
        let requestURL = URL(string: String(format: "%@%@",kBaseUrl,kevents))!
        
        let param : NSMutableDictionary = [:]
        
        NetworkManager.sharedInstance.postRequest(requestURL, hude: true, showSystemError: false, loadingText: false, params: param , completionHandler:{(dict) in
            
            print(dict)
            let status : String = String(format:"%@", dict[kstatus]! as! CVarArg)
            if status == "200" {
                if let payload = dict.value(forKey: kpayload) as? [String : Any] {
                    let pastCount = payload["past_event_count"] as? Int
                    let upcomingCount = payload["upcoming_event_count"] as? Int
                    let upcomingList = payload["upcoming_event"] as? [[String : Any]]
                    let upcomingEvent = Mapper<EventModel>().mapArray(JSONArray: upcomingList!)
                    let pastList = payload["past_events"] as? [[String : Any]]
                    let pastEvent = Mapper<EventModel>().mapArray(JSONArray: pastList!)
                    allEventListHandler(upcomingEvent, upcomingCount ?? 0, pastEvent, pastCount ?? 0, true, "")
                }
            } else {
                let message = dict[kmessage] as? String
                allEventListHandler([],0,[],0, false, message!)
            }
        })
    }
}
