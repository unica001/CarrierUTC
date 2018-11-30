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
    func getBlogList(categoryId: Int, pageIndex: Int, allListHandler: @escaping ([BlogModel], Int, Bool, String) -> Void)
}

class BlogListVM: BlogListViewModelling {
    
    func getBlogList(categoryId: Int, pageIndex: Int, allListHandler: @escaping ([BlogModel], Int, Bool, String) -> Void) {
        let requestURL = URL(string: String(format: "%@%@",kBaseUrl,kblog_list))!
        
        let param : NSMutableDictionary = ["category_id": categoryId,
                                           "page_no" : pageIndex]
        
        NetworkManager.sharedInstance.postRequest(requestURL, hude: true, showSystemError: false, loadingText: false, params: param , completionHandler:{(dict) in
            
            print(dict)
            let status : String = String(format:"%@", dict[kstatus]! as! CVarArg)
            if status == "200" {
                if let payload = dict.value(forKey: kpayload) as? [String : Any] {
                    let totalCount = payload["total_blogs"] as? Int
                    let list = payload["blogs"] as? [[String : Any]]
                    let blogCategory = Mapper<BlogModel>().mapArray(JSONArray: list!)
                    allListHandler(blogCategory,totalCount!, true, "")
                }
            } else {
                let message = dict[kmessage] as? String
                allListHandler([], 0, false, message!)
            }
        })
    }
}
