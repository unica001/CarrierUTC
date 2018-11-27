//
//  RegisterVM.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 26/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation

struct RegisterStruct {
    var type : RegisterType!
    var placeholder: String!
    var value: String!
    var isTerms : Bool!
    
    init(type: RegisterType, placeholder: String, value: String, isTerms: Bool = false) {
        self.type = type
        self.placeholder = placeholder
        self.value = value
        self.isTerms = isTerms
    }
    
    mutating func updateValue(inValue: String) {
        self.value = inValue
    }
}

protocol RegisterViewModelling {
    func prepareRegisterFields() -> [RegisterStruct]
    func validateFields(dataStore: [RegisterStruct], validHandler: @escaping (_ param : [String : AnyObject], _ msg : String, _ succes : Bool) -> Void)
    func register(param: [String : AnyObject], registerHandler: @escaping (_ response: [String:AnyObject],  _ success: Bool, _ message: String)-> Void)
}

class RegisterVM: RegisterViewModelling {
    
    func prepareRegisterFields() -> [RegisterStruct] {
        var dataStruct = [RegisterStruct]()
        dataStruct.append(RegisterStruct(type: RegisterType.Name, placeholder: "Name", value: ""))
        dataStruct.append(RegisterStruct(type: RegisterType.Phone, placeholder: "Phone", value: ""))
        dataStruct.append(RegisterStruct(type: RegisterType.Email, placeholder: "Email", value: ""))
        dataStruct.append(RegisterStruct(type: RegisterType.Submit, placeholder: "Submit", value: ""))
        return dataStruct
    }
    
    func validateFields(dataStore: [RegisterStruct], validHandler: @escaping (_ param : [String : AnyObject], _ msg : String, _ succes : Bool) -> Void) {
        var dictParam = [String : AnyObject]()
        for index in 0..<dataStore.count {
            let type = dataStore[index].type as! RegisterType
            switch type {
            case RegisterType.Name:
                if dataStore[index].value.trimmingCharacters(in: .whitespaces) == "" {
                    validHandler([:], "Please enter name", false)
                    return
                }
                dictParam["name"] = dataStore[index].value.trimmingCharacters(in: .whitespaces) as AnyObject
            case RegisterType.Phone:
                if dataStore[index].value.trimmingCharacters(in: .whitespaces) != "" && (dataStore[index].value.trimmingCharacters(in: .whitespaces).count < 10) {
                    validHandler([:], "Please enter phone number", false)
                    return
                }
                dictParam["phone"] = dataStore[index].value.trimmingCharacters(in: .whitespaces) as AnyObject
            case RegisterType.Email:
                if dataStore[index].value.trimmingCharacters(in: .whitespaces) == "" {
                    validHandler([:], "Please enter email id", false)
                    return
                } else if !Helper.isValidEmail(emailString: dataStore[index].value.trimmingCharacters(in: .whitespaces), strictFilter: true) {
                    validHandler([:], "Please enter valid email id", false)
                    return
                }
                dictParam["email"] = dataStore[index].value.trimmingCharacters(in: .whitespaces) as AnyObject
                break
            case RegisterType.Submit:
                break
            }
        }
        dictParam["device_id"] = Constant.kAppDelegate.deviceToken as AnyObject
        validHandler(dictParam, "", true)
    }
    
    func register(param: [String : AnyObject], registerHandler: @escaping (_ response: [String:AnyObject],  _ success: Bool, _ message: String)-> Void) {
        let requestURL = URL(string: String(format: "%@%@",kBaseUrl,kregistration))!
        
        let dictParam = NSMutableDictionary(dictionary: param)
        NetworkManager.sharedInstance.postRequest(requestURL, hude: true, showSystemError: false, loadingText: false, params: dictParam , completionHandler:{(dict) in
            print(dict)
            let status : String = String(format:"%@", dict[kstatus]! as! CVarArg)
            if status == "200" {
                registerHandler([:], true, "")
            } else {
                let message = dict[kmessage] as? String
                registerHandler([:], false, message!)
            }
        })
    }
}
