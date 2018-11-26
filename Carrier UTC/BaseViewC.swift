//
//  BaseViewC.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 23/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class BaseViewC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 5
        
        self.tabBarController?.tabBar.layer.masksToBounds = false
        self.tabBarController?.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBarController?.tabBar.layer.shadowOpacity = 0.8
        self.tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0, height: -10.0)
        self.tabBarController?.tabBar.layer.shadowRadius = 10
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

}
