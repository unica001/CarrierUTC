//
//  PMScaleModel.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 28/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

class PMScaleModel: NSObject, Codable, Mappable {
    
    var pm25_value: String?
    var color_code: String?
    var pm10_value: String?
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        pm25_value <- map["pm25_value"]
        color_code <- map["color_code"]
        pm10_value <- map["pm10_value"]
        name <- map["name"]
    }
    
}
