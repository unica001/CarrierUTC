//
//  WebViewC.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 27/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit
import WebKit

class WebViewC: BaseViewC {
    //MARK:- IBOutlets
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var btnBack: UIButton!
    
    var strHeader = ""
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setUp() {
        self.viewHeader.addShadowInHeader()
        self.lblHeader.text = strHeader
        var url : URL!
        if strHeader == "Terms and Conditions" {
            url = URL(string: ContentUrl.Terms.rawValue)
            btnBack.isHidden = false
        } else  if strHeader == "Privacy Policy" {
            url = URL(string: ContentUrl.Privacy.rawValue)
            btnBack.isHidden = false
        } else {
            self.lblHeader.text = "About Us"
            url = URL(string: ContentUrl.About.rawValue)
            btnBack.isHidden = true
        }
        
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    @IBAction func tapBack(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
