//
//  BlogListVM.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 30/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

protocol BlogListViewModelling {
    
}

class BlogListVM: BlogListViewModelling {
    
    func getBlogList(categoryId: String, pageIndex: Int, allListHandler: @escaping ([BlogModel], Bool, String) -> Void) {
        let requestURL = URL(string: String(format: "%@%@",kBaseUrl,kblog_list))!
        
        let param : NSMutableDictionary = ["category_id": categoryId,
                                           "page_no" : pageIndex]
        
        NetworkManager.sharedInstance.postRequest(requestURL, hude: true, showSystemError: false, loadingText: false, params: param , completionHandler:{(dict) in
            
            print(dict)
            let status : String = String(format:"%@", dict[kstatus]! as! CVarArg)
            if status == "200" {
                if let payload = dict.value(forKey: kpayload) as? [[String : Any]] {
                    
                    let blogCategory = Mapper<BlogModel>().mapArray(JSONArray: payload)
                    allListHandler(blogCategory, true, "")
                }
            } else {
                let message = dict[kmessage] as? String
                allListHandler([], false, message!)
            }
        })
    }
}
