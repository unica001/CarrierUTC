//
//  HomeModele.swift
//  Carrier UTC
//
//  Created by Ram Niwas on 26/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

class HomeModele: NSObject,Mappable,Codable {
    
    var pmType25 : PMTypeModele?
    var pmType10 : PMTypeModele?
    var healthPrecaution  : HealthPrecaution?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.pmType25 <- map["PM25"]
        self.pmType10 <- map["PM10"]
        self.healthPrecaution <- map["health_precaution"]
    }
}
