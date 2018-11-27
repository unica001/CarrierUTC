//
//  health_precaution.swift
//  Carrier UTC
//
//  Created by Ram Niwas on 26/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

class HealthPrecaution: NSObject,Mappable,Codable{
    
    var preference_text: String?
    var preference_image : String?
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        self.preference_text <- map["preference_text"]
        self.preference_image <- map["preference_image"]
    }
}
