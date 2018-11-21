
import UIKit

class NetworkManager: NSObject {
    
    private let HeaderAccessToken = "##123"

    class var sharedInstance: NetworkManager {
        
        struct Static {
            static let instance = NetworkManager()
        }
        return Static.instance
    }
    
    //MARK: Post request with json data method
    
    func postRequest(_ url: URL, hude:Bool, isAuthentication: Bool = false,showSystemError:Bool,loadingText:Bool, params: NSMutableDictionary, completionHandler:@escaping (_ response: NSDictionary) -> Void) {
        
        // show hude
        if hude == true {
           // SKActivityIndicator.show()
        }
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: url)
        let session = URLSession.shared
        urlRequest.httpMethod = "POST"
        print(params)
        
        let httpData = createHttpBody(sharingDictionary: params)
        
        urlRequest.httpBody = httpData
        print(urlRequest.httpBody!)
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(HeaderAccessToken, forHTTPHeaderField: "accessToken")
//        if !isAuthentication {
//            if (kUserDefault.value(forKey: kloginInfo) != nil) {
//                let loginInfoDictionary = NSKeyedUnarchiver.unarchiveObject(with: kUserDefault.value(forKey: kloginInfo) as! Data) as! NSMutableDictionary
//                if let customerAccessToken = loginInfoDictionary["CustomerAccessToken"] as? String {
//                    urlRequest.setValue(customerAccessToken, forHTTPHeaderField: "CustomerAccessToken")
//                }
//                
//            }
//           
//        }
        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {
            
            (data, response, error) -> Void in
            
            // hide hude
            DispatchQueue.main.sync {
              //  SKActivityIndicator.dismiss()
            }
            
            
            if error != nil {
                print("Error occurred: "+(error?.localizedDescription)!)
                
                DispatchQueue.main.sync {
                    let appDelegate :AppDelegate = UIApplication.shared.delegate as! AppDelegate
                   Alert.Alert((error?.localizedDescription)!, okButtonTitle: "OK", target: appDelegate.window?.rootViewController)
                }
                return;
            }
            do {
                
                let responseObjc = try (JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary) as Dictionary
                
                completionHandler(responseObjc as NSDictionary)
            }
            catch {
                print("Error occurred parsing data: \(error.localizedDescription)")
             
                return;
            }
            
        })
        
        task.resume()
    }
    
    
    //MARK: getRequest request method
    
    func getRequest(_ url: URL, hude:Bool,showSystemError:Bool,loadingText:Bool, params: NSMutableDictionary, completionHandler:@escaping (_ response: Dictionary <String, AnyObject>?) -> Void) {
        
        // show hude
        if hude == true {
           // SKActivityIndicator.show()
        }
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: url)
        let session = URLSession.shared
        urlRequest.httpMethod = "GET"
        print(params)
        
        urlRequest.httpBody = nil
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(HeaderAccessToken, forHTTPHeaderField: "accessToken")

        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {
            (data, response, error) -> Void in
            
            // hide hude
            DispatchQueue.main.sync {
             //   SKActivityIndicator.dismiss()
            }
            
            if error != nil {
                print("Error occurred: "+(error?.localizedDescription)!)
                
                DispatchQueue.main.sync {
                }
                let appDelegate :AppDelegate = UIApplication.shared.delegate as! AppDelegate
                
                Alert.Alert((error?.localizedDescription)!, okButtonTitle: "OK", target: appDelegate.window?.rootViewController)
                return;
            }
            do {
                let responseObjc = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                completionHandler(responseObjc)
            }
            catch {
                print("Error occurred parsing data: \(error)")
                completionHandler([:])
            }
        })
        
        task.resume()
    }
    
    
    func createHttpBody(sharingDictionary : NSMutableDictionary) -> Data
    {
        let parameterArray : NSMutableArray = []
        
        for keyValue in sharingDictionary.allKeys
        {
            let keyString = "\(keyValue)=\(sharingDictionary[keyValue]!)"
            parameterArray.add(keyString)
        }
        var postString = String()
        
        postString = parameterArray.componentsJoined(by: "&")
        print(postString)
        return postString.data(using: .utf8)!
    }
}
extension NSMutableData {
    
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
