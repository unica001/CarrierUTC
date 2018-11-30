//
//  HomeViewController.swift
//  Carrier UTC
//
//  Created by Ram Niwas on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0


class HomeViewController: BaseViewC {
    
    @IBOutlet weak var lblMonitor: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var circleViewHeight: NSLayoutConstraint!

    @IBOutlet weak var pm25AirQualityType: UILabel!
    @IBOutlet weak var pm10QualityType: UILabel!

    @IBOutlet weak var pm10Point: UILabel!
    @IBOutlet weak var pm25Point: UILabel!

    @IBOutlet weak var pm10AnimationView: UIView!
    @IBOutlet weak var pm25AnimationView: UIView!

    @IBOutlet weak var pm10View: UIView!
    @IBOutlet weak var pm25View: UIView!
    
    @IBOutlet weak var circleView: UIView!
    
    internal var viewModel : HomeModelling!
    internal var notificationModel : NotificationModel!
    
    @IBOutlet weak var collectionTip: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var startCnstCollection: NSLayoutConstraint!
    
    let degreeValue : Float = 1.44
    let animationDuration = TimeInterval(3)
    
    var arrArea = [AreaModel]()
    var arrHealth = [HealthPrecaution]() {
        didSet {
            self.collectionTip.reloadData()
        }
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblMonitor.roundCorners(borderWidth: 0.2, borderColor: UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor, cornerRadius: 5)
//        let shadowSize : CGFloat = 10.0
//        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
//                                                   y: -shadowSize / 2,
//                                                   width: self.viewHeader.frame.size.width + shadowSize,
//                                                   height: self.viewHeader.frame.size.height + shadowSize))
//        self.viewHeader.layer.masksToBounds = false
//        self.viewHeader.layer.shadowColor = UIColor.black.cgColor
//        self.viewHeader.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        self.viewHeader.layer.shadowOpacity = 0.5
//        self.viewHeader.layer.shadowPath = shadowPath.cgPath
//        self.viewHeader.layer.cornerRadius = 13.0
        self.viewHeader.layer.shadowColor = UIColor.lightGray.cgColor
        self.viewHeader.layer.shadowOpacity = 0.5
        self.viewHeader.layer.shadowRadius = 20.0
        self.viewHeader.layer.shadowOffset = .zero
        self.viewHeader.layer.shadowPath = UIBezierPath(rect: self.viewHeader.bounds).cgPath
//        self.viewHeader.layer.shouldRasterize = true
//        viewHeader.layer.shadowColor = UIColor.black.cgColor
//        viewHeader.layer.shadowOpacity = 0.7
//        viewHeader.layer.shadowOffset = CGSize.zero
//        viewHeader.layer.shadowRadius = 4
//        viewHeader.layer.shadowPath = UIBezierPath(rect: viewHeader.bounds).cgPath
        
        circleViewHeight.constant = (self.view.frame.size.width-20)/2
        
        setUp()
    
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  
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
        if self.notificationModel == nil {
            self.notificationModel = notificationsViewModelling()
        }
        self.collectionTip.register(UINib(nibName: "TipsCell", bundle: nil), forCellWithReuseIdentifier: "TipsCell")
       getHomeViewDetails()
      
    }
    
    func getHomeViewDetails(){
        
        self.viewModel?.getHomeViewDetails(handler:{[weak self] (health_precaution,PM10,PM25,areaList, msg, isSuccess) in
            if isSuccess == true{
                self!.circleView.isHidden = false
                self!.arrArea = areaList
                self!.setData(healthPrecautionList: health_precaution, pm10: PM10, pm25: PM25)
            }
        })
    }
    
    func setData(healthPrecautionList: [HealthPrecaution],pm10 : PMTypeModele,pm25 : PMTypeModele){
        let cellSizes = CGFloat(115 * healthPrecautionList.count)
        let xAxis = (Constant.kScreenWidth) - cellSizes
        if cellSizes < Constant.kScreenWidth {
            self.startCnstCollection.constant =  xAxis/2
            self.collectionTip.updateConstraints()
        }
        if Constant.kAppDelegate.appLocation == nil {
            Constant.kAppDelegate.appLocation = arrArea.first
        }
        self.notificationModel.sendDeviceTokenOnServer { (msg, success) in
            
        }
        addressLabel.text = Constant.kAppDelegate.appLocation.name
        
        self.arrHealth = healthPrecautionList
        
        let pm10Values = NSString(format: "%.0f",  pm10.value!)
        pm10Point.textColor = UIColor.colorWith(hexString: pm10.color!)
        pm10QualityType.text = pm10.quality
        
        let pm25Values = NSString(format: "%.0f",  pm25.value!)
        pm25Point.textColor = UIColor.colorWith(hexString: pm25.color!)
        pm25AirQualityType.text = pm25.quality
        showCircleAnimation(pm25Values:pm25Values as String, pm10Values:pm10Values as String)
        
        tableView.reloadData()
    }
  
    func showCircleAnimation(pm25Values : String, pm10Values : String){
       self.pm25AnimationView.layer.removeAllAnimations()
        self.pm10AnimationView.layer.removeAllAnimations()
        
        self.pm25AnimationView.transform = CGAffineTransform(rotationAngle:CGFloat(0))
        self.pm10AnimationView.transform = CGAffineTransform(rotationAngle:CGFloat(0))



        // PM2.5 Animation
        var  airPolutionPM25Value : Float = Float(pm25Values)!
        
        //  check 180 angles or values not more then 125
        
        incrementPM25(to: Int(airPolutionPM25Value))

        
        if airPolutionPM25Value < 125 {
            UIView.animate(withDuration: animationDuration) { () -> Void in
                let point : Float = 180/(airPolutionPM25Value * self.degreeValue)
                let angle =   CGFloat.pi / CGFloat(point)
                self.pm25AnimationView.transform = CGAffineTransform(rotationAngle:CGFloat(angle))
            }
        }
        else {
            UIView.animate(withDuration: animationDuration) { () -> Void in
                let point : Float = 180/(125 * self.degreeValue)
                let angle =   CGFloat.pi / CGFloat(point)
                self.pm25AnimationView.transform = CGAffineTransform(rotationAngle:CGFloat(angle))
            }
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
                
                if airPolutionPM25Value > 240 {
                airPolutionPM25Value = 239
                }
                let point : Float = 360/(airPolutionPM25Value * self.degreeValue)
                let angle =   CGFloat.pi / CGFloat(point)
                self.pm25AnimationView.transform = CGAffineTransform(rotationAngle: angle*2)
            }, completion: nil)
        }
        
        
        // PM10 Animation
        var  airPolutionPM10Value : Float = Float(pm10Values)!
        incrementPM10(to: Int(airPolutionPM10Value))

        //  check 180 angles or values not more then 125
        
        if airPolutionPM10Value < 250 {
            UIView.animate(withDuration: animationDuration) { () -> Void in
                let point : Float = 250/(airPolutionPM10Value )
                let angle =   CGFloat.pi / CGFloat(point)
                self.pm10AnimationView.transform = CGAffineTransform(rotationAngle:CGFloat(angle))
            }
        }
        else {
            UIView.animate(withDuration: animationDuration) { () -> Void in
                let point : Float = 1
                let angle =   CGFloat.pi / CGFloat(point)
                self.pm10AnimationView.transform = CGAffineTransform(rotationAngle:CGFloat(angle))
            }
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
                
                if airPolutionPM10Value > 500 {
                    airPolutionPM10Value = 480
                }
                let point : Float = 500/(airPolutionPM10Value)
                let angle =   (CGFloat.pi) / CGFloat(point)
                self.pm10AnimationView.transform = CGAffineTransform(rotationAngle: angle*2)
            }, completion: nil)
        }
    }
    
    func incrementPM25(to endValue: Int) {
        let duration: Double = animationDuration //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.pm25Point.text = "\(i)"
                }
            }
        }
    }
    
    func incrementPM10(to endValue: Int) {
        let duration: Double = animationDuration //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.pm10Point.text = "\(i)"
    
                }
            }
        }
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
    
    @IBAction func tapLocation(_ sender: UIButton) {
        let nameArray = arrArea.map { $0.name }
        ActionSheetStringPicker.show(withTitle: "Location", rows: nameArray as [Any], initialSelection: 0, doneBlock: { (picker, value, index) in
            Constant.kAppDelegate.appLocation = self.arrArea[value]
            self.addressLabel.text = Constant.kAppDelegate.appLocation.name
            self.getHomeViewDetails()
        }, cancel: { ActionStringCancelBlock in return }, origin: self.parent?.view)
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrHealth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TipsCell", for: indexPath) as! TipsCell
        cell.setUPTips(healthData: arrHealth[indexPath.row], index: indexPath.row, totalCount: arrHealth.count)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 125) // The size of one cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // margin between cells
    }
}
