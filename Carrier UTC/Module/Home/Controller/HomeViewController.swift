//
//  HomeViewController.swift
//  Carrier UTC
//
//  Created by Ram Niwas on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewC {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var circleViewHeight: NSLayoutConstraint!
    @IBOutlet weak var polutionArrow: UIImageView!
    @IBOutlet weak var precautionImage1: UIImageView!
    @IBOutlet weak var precautionImage2: UIImageView!
    
    @IBOutlet weak var precautionLabel1: UILabel!
    @IBOutlet weak var precautionLabel2: UILabel!

    @IBOutlet weak var pm25Point: UILabel!
    @IBOutlet weak var pm25AirQualityType: UILabel!
    
    @IBOutlet weak var pm10Point: UILabel!
    @IBOutlet weak var pm10QualityType: UILabel!
    
    @IBOutlet weak var circleView: UIView!
    internal var viewModel : HomeModelling!
    
    @IBOutlet weak var tableView: UITableView!
    
    var appDelegate : AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewHeader.roundCorners(borderWidth: 1, borderColor: UIColor.clear.cgColor, cornerRadius: 5)
        viewHeader.insertShadow(shadowRadius: 1, width: 3, height: 3, shadowColor: UIColor.lightGray.cgColor)
        viewHeader.layer.masksToBounds = true
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        circleViewHeight.constant = (self.view.frame.size.width-20)/2
        
        setUp()
//        UIView.animate(withDuration: 0.5, animations: {
//            self.polutionArrow.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi)))
//        }) { (isAnimationComplete) in
//            // Animation completed
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //MARK: - Private Methods
    private func setUp() {
        
        if self.viewModel == nil {
            self.viewModel = HomeViewModelling()
        }
       getHomeViewDetails()
        
    }
    
    func getHomeViewDetails(){
        
        self.viewModel?.getHomeViewDetails(lat: "28.500", lng: "77.0805", handler:{[weak self] (health_precaution,PM10,PM25, msg, isSuccess) in
            if isSuccess == true{
                self!.circleView.isHidden = false
        self!.setData(healthPrecautionList: health_precaution, pm10: PM10, pm25: PM25)
            }
        })
    }
    
    func setData(healthPrecautionList: [HealthPrecaution],pm10 : PMTypeModele,pm25 : PMTypeModele){
        
        precautionImage1.setImageWith(strImage:healthPrecautionList[0].preference_image)
        precautionLabel1.text = healthPrecautionList[0].preference_text
        precautionImage2.setImageWith(strImage:healthPrecautionList[1].preference_image)
        precautionLabel2.text = healthPrecautionList[1].preference_text
        
        let pm10Values = NSString(format: "%.0f",  pm10.value!)
        pm10Point.text = pm10Values as String
        pm10Point.textColor = UIColor.colorWith(hexString: pm10.color!)
        pm10QualityType.text = pm10.quality
        
        let pm25Values = NSString(format: "%.0f",  pm25.value!)
        pm25Point.text = pm25Values as String
        pm25Point.textColor = UIColor.colorWith(hexString: pm25.color!)
        pm25AirQualityType.text = pm25.quality
     
        tableView.reloadData()
    }
  
    

    @IBAction func pm25DetailsAction(_ sender: Any) {
        self.performSegue(withIdentifier: kairQualitySegueIdentifier, sender: nil)
    }
    @IBAction func tapRegister(_ sender: UIButton) {
        if let searchEventViewC = Constant.kStoryboardEvent.instantiateViewController(withIdentifier: "RegisterViewC") as? RegisterViewC {
            self.navigationController?.pushViewController(searchEventViewC, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressLabel.text = appDelegate.currentAddress
        }
}


