//
//  HomeViewModele.swift
//  Carrier UTC
//
//  Created by Ram Niwas on 26/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation
import ObjectMapper

protocol HomeModelling {
    
    func getHomeViewDetails(lat: String,lng:String, handler : @escaping (_ health_precaution :[HealthPrecaution],_ pm10Type:PMTypeModele,_ pm25Type : PMTypeModele,_ message : String,_ sucess : Bool)-> Void)
}

class HomeViewModelling: HomeModelling {
    
    func getHomeViewDetails(lat: String,lng:String, handler : @escaping (_ health_precaution :[HealthPrecaution],_ pm10Type:PMTypeModele,_ pm25Type : PMTypeModele,_ message : String,_ sucess : Bool)-> Void){
        
        let requestURL = URL(string: String(format: "%@%@",kBaseUrl,kair_pollution))!
        
        let param : NSMutableDictionary = [:]
         param["lat"] = lat
        param["lon"] = lng
        
        NetworkManager.sharedInstance.postRequest(requestURL, hude: true, showSystemError: false, loadingText: false, params: param , completionHandler:{(dict) in
            
            print(dict)
            let status : String = String(format:"%@", dict[kstatus]! as! CVarArg)
            
            if status == "200" {
                if let payload = dict.value(forKey: kpayload) as? [String : Any] {
                    let health_precaution = payload["health_precaution"] as? [[String : Any]]
                     let PM25Type = payload["PM25"] as? [String : Any]
                     let PM10Type = payload["PM10"] as? [String : Any]
                    
                     let health_precautionMapper = Mapper<HealthPrecaution>().mapArray(JSONArray: health_precaution!)
                    let PM25TypeMapper = Mapper<PMTypeModele>().map(JSON: PM25Type!)
                    let PM10TypeMapper = Mapper<PMTypeModele>().map(JSON: PM10Type!)
                    
                    handler(health_precautionMapper,PM10TypeMapper!,PM25TypeMapper!,"",true)

                }
            } else {
                let message = dict[kmessage] as? String
                
             //   handler([],pm10Type,[:],"",true)
            }
        })
    }
}
