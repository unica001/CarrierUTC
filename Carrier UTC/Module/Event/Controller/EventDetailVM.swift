//
//  EventDetailVM.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 23/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

protocol EventDetailViewModelling {
    func getEventDetail(eventId: Int, eventDetailHandler: @escaping (_ eventResponse: EventModel,  _ success: Bool, _ message: String)-> Void)
    
    func setInterestedEvent(eventId: Int, interestedEventHandler: @escaping (_ success : Bool, _ message: String) -> Void)
}

class EventDetailVM: EventDetailViewModelling {
    func getEventDetail(eventId: Int, eventDetailHandler: @escaping (_ eventResponse: EventModel,  _ success: Bool, _ message: String)-> Void) {
        let requestURL = URL(string: String(format: "%@%@",kBaseUrl,kevent_detail))!
        
        let param : NSMutableDictionary = ["event_id" : eventId,
                                           "device_id" : Constant.kAppDelegate.fcmToken]
        
        
        NetworkManager.sharedInstance.postRequest(requestURL, hude: true, showSystemError: false, loadingText: false, params: param , completionHandler:{(dict) in
            
            print(dict)
            let status : String = String(format:"%@", dict[kstatus]! as! CVarArg)
            if status == "200" {
                if let payload = dict.value(forKey: kpayload) as? [String : Any] {
                    let list = payload["event"] as! [String : Any]
                    let event = Mapper<EventModel>().map(JSON: list)
                    eventDetailHandler(event!, true, "")
                }
            } else {
                let message = dict[kmessage] as? String
//                eventDetailHandler([], false, message!)
            }
        })
    }
    
    func setInterestedEvent(eventId: Int, interestedEventHandler: @escaping (_ success : Bool, _ message: String) -> Void) {
        let requestURL = URL(string: String(format: "%@%@",kBaseUrl,kinterested_event))!
        let param : NSMutableDictionary = ["event_id" : eventId,
                                           "device_id" : Constant.kAppDelegate.fcmToken]
        
        NetworkManager.sharedInstance.postRequest(requestURL, hude: true, showSystemError: false, loadingText: false, params: param , completionHandler:{(dict) in
            
            print(dict)
            let status : String = String(format:"%@", dict[kstatus]! as! CVarArg)
            if status == "200" {
                interestedEventHandler(true, "")
            } else {
                let message = dict[kmessage] as? String
                interestedEventHandler(false, message!)
            }
        })
    }
}
