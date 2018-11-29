//
//  BlogCategoryModel.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 27/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit
import ObjectMapper

class BlogCategoryModel: NSObject, Codable,Mappable {

    var image: String?
    var name: String?
    var id: Int?
    var blog_count: Int?
    var color_code: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        image <- map["image"]
        blog_count <- map["blog_count"]
        name <- map["name"]
        id <- map["id"]
        color_code <- map["color_code"]
    }

    
}
