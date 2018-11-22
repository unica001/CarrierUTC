//
//  AirQualityModole.swift
//  Carrier UTC
//
//  Created by Ram Niwas on 22/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

class AirQualityModele : NSObject, Codable, Mappable{
    
    var display_text : String?
    var color : String?
    var name : String?
    var level : String?
    
    required init?(map: Map) {
    }
    
     func mapping(map: Map) {
        self.display_text <- map["display_text"]
        self.color <- map["color"]
        self.name <- map["name"]
        self.level <- map["level"]
    }   
}
