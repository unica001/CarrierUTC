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
    @IBOutlet weak var precautionImage1: UIImageView!
    @IBOutlet weak var precautionImage2: UIImageView!
    
    @IBOutlet weak var precautionLabel1: UILabel!
    @IBOutlet weak var precautionLabel2: UILabel!

    @IBOutlet weak var pm25Point: UILabel!
    @IBOutlet weak var pm25AirQualityType: UILabel!
    
    @IBOutlet weak var pm10Point: UILabel!
    @IBOutlet weak var pm10QualityType: UILabel!
    
    @IBOutlet weak var pm25CircleView: UIView!
    @IBOutlet weak var circleView: UIView!
    internal var viewModel : HomeModelling!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var animationView1: UIView!
    var appDelegate : AppDelegate!
    
    let  degreeValue : Float = 1.44 // total point count /  actual point
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewHeader.roundCorners(borderWidth: 1, borderColor: UIColor.clear.cgColor, cornerRadius: 5)
        viewHeader.insertShadow(shadowRadius: 1, width: 3, height: 3, shadowColor: UIColor.lightGray.cgColor)
        viewHeader.layer.masksToBounds = true
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        circleViewHeight.constant = (self.view.frame.size.width-20)/2
        
        setUp()
 
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressLabel.text = appDelegate.currentAddress
        
        let  airPolutionValue : Float = 120

        //  check 180 angles or values not more then 125
        
        if airPolutionValue < 125 {
            UIView.animate(withDuration: 5) { () -> Void in
                let point : Float = 180/(airPolutionValue * self.degreeValue)
                let angle =   CGFloat.pi / CGFloat(point)
                self.animationView1.transform = CGAffineTransform(rotationAngle:CGFloat(angle))
            }
        }
        else {
            UIView.animate(withDuration: 5) { () -> Void in
                let point : Float = 180/(125 * self.degreeValue)
                let angle =   CGFloat.pi / CGFloat(point)
                self.animationView1.transform = CGAffineTransform(rotationAngle:CGFloat(angle))
            }
            
            UIView.animate(withDuration: 5, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
                let point : Float = 360/(240 * self.degreeValue)
                let angle =   CGFloat.pi / CGFloat(point)
                self.animationView1.transform = CGAffineTransform(rotationAngle: angle*2)
            }, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kairQualitySegueIdentifier {
            let airQuality = segue.destination as? AirQualityDetailController
            let btn = sender as! UIButton
            airQuality?.strHeader = (btn.tag == 10) ? "PM 2.5 LEVELS" : "PM 10 LEVELS"
        }
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
  
    
    //MARK: - IBAction Methods
    @IBAction func pm25DetailsAction(_ sender: Any) {
        self.performSegue(withIdentifier: kairQualitySegueIdentifier, sender: sender)
    }
    
    @IBAction func tapRegister(_ sender: UIButton) {
        if let registerViewC = Constant.kStoryboardEvent.instantiateViewController(withIdentifier: "RegisterViewC") as? RegisterViewC {
            self.navigationController?.pushViewController(registerViewC, animated: true)
        }
    }
    
    @IBAction func tapHistory(_ sender: UIButton) {
        if let historyViewC = Constant.kStoryboardMain.instantiateViewController(withIdentifier: "HistoryViewC") as? HistoryViewC {
            self.navigationController?.pushViewController(historyViewC, animated: true)
        }
    }
    
}


