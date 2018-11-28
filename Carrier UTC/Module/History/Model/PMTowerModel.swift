//
//  PMTowerModel.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 28/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

class PMTowerModel: NSObject, Codable, Mappable {
    
    var date: String?
    var minimum: String?
    var maximum: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        maximum <- map["maximum"]
        minimum <- map["minimum"]
        date <- map["date"]
    }
    
}
