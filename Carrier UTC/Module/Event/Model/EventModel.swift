//
//  EventModel.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 22/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit
import ObjectMapper

class EventModel: NSObject, Codable, Mappable {
    
    var event_description: String?
    var event_image: String?
    var id: Int?
    var event_address: String?
    var event_date: String?
    var latitude: Double?
    var longitude: Double?
    var heading: String?
    var event_time: String?
    var interested_users: Int?
    var user_interest: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        event_description <- map["description"]
        event_date <- map["event_date"]
        event_time <- map["event_time"]
        event_image <- map["event_image"]
        id <- map["id"]
        event_address <- map["event_address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        heading <- map["heading"]
        user_interest <- map["user_interest"]
        interested_users <- map["number_interested_users"]
    }

}
