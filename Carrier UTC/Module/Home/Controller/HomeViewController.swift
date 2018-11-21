//
//  HomeViewController.swift
//  Carrier UTC
//
//  Created by Ram Niwas on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var airQualityLabel: UILabel!
    @IBOutlet weak var lastTimeUpdateLabel: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    
    var appDelegate : AppDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewHeader.roundCorners(borderWidth: 1, borderColor: UIColor.clear.cgColor, cornerRadius: 5)
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressLabel.text = appDelegate.currentAddress

    }
 
}
