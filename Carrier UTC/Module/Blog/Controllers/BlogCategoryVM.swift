//
//  BlogCategoryVM.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 27/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

protocol BlogCategoryViewModelling {
    func getBlogCategory(allEventListHandler: @escaping ([BlogCategoryModel], Bool, String) -> Void)
}

class BlogCategoryVM: BlogCategoryViewModelling {

    func getBlogCategory(allEventListHandler: @escaping ([BlogCategoryModel], Bool, String) -> Void) {
        let requestURL = URL(string: String(format: "%@%@",kBaseUrl,kblog_categories))!
        
        let param : NSMutableDictionary = [:]
        
        NetworkManager.sharedInstance.postRequest(requestURL, hude: true, showSystemError: false, loadingText: false, params: param , completionHandler:{(dict) in
            
            print(dict)
            let status : String = String(format:"%@", dict[kstatus]! as! CVarArg)
            if status == "200" {
                if let payload = dict.value(forKey: kpayload) as? [[String : Any]] {
                
                    let blogCategory = Mapper<BlogCategoryModel>().mapArray(JSONArray: payload)
                    allEventListHandler(blogCategory, true, "")
                }
            } else {
                let message = dict[kmessage] as? String
                allEventListHandler([], false, message!)
            }
        })
    }
}
