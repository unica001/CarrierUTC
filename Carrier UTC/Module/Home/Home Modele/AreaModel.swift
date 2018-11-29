//
//  AreaModel.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 29/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit
import ObjectMapper

class AreaModel: NSObject, Codable, Mappable {
    var id: Int?
    var name: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
    }
}
