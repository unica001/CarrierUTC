//
//  PMTypeModele.swift
//  Carrier UTC
//
//  Created by Ram Niwas on 26/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

class PMTypeModele: NSObject,Mappable,Codable {
    var color : String?
    var quality : String?
    var  value : Float?
    
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        self.color <- map["color"]
         self.quality <- map["quality"]
         self.value <- map["value"]
    }
}
