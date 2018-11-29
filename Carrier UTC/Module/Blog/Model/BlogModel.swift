//
//  BlogModel.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 29/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

class BlogModel: NSObject, Codable,Mappable {
    
    var category: String?
    var create_date: String?
    var id: Int?
    var category_id: Int?
    var desc: String?
    var heading: String?
    var event_image: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        category <- map["category"]
        create_date <- map["create_date"]
        category_id <- map["category_id"]
        id <- map["id"]
        heading <- map["heading"]
        event_image <- map["event_image"]
        desc <- map["desc"]
    }
    
    
}

