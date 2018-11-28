//
//  HistoryModel.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 28/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

class HistoryModel: NSObject, Codable, Mappable {
    
    var pm_scale: [PMScaleModel]!
    var pm10: [PMTowerModel]!
    var pm25: [PMTowerModel]!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        pm_scale <- map["pm_scale"]
        pm10 <- map["pm10"]
        pm25 <- map["pm25"]
    }
    
}
