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
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewHeader.roundCorners(borderWidth: 1, borderColor: UIColor.clear.cgColor, cornerRadius: 5)
        viewHeader.insertShadow(shadowRadius: 1, width: 3, height: 3, shadowColor: UIColor.lightGray.cgColor)
        viewHeader.layer.masksToBounds = true
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        circleViewHeight.constant = (self.view.frame.size.width-20)/2
        
        setUp()
        
//        int angle = 0; // start angle position 0-360 deg
//        CGPoint center = self.view.center;
//        CGPoint start = [self setPointToAngle:angle center:center radius:radius]; //point for start moving
//        CGMutablePathRef path = CGPathCreateMutable();
//        CGPathMoveToPoint(path, NULL, start.x, start.y);
//
//        for(int a =0;a<4;a++) //set path points for 90, 180, 270,360 deg form begining angle
//        {
//            angle+=45;
//            expPoint = [self setPointToAngle:angle center:center radius:expRadius];
//            angle+=45;
//            start = [self setPointToAngle:angle center:center radius:radius];
//            CGPathAddQuadCurveToPoint(path, NULL,expPoint.x, expPoint.y, start.x, start.y);
//        }
//
//        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//        pathAnimation.removedOnCompletion = NO;
//        pathAnimation.path = path;
//        [pathAnimation setCalculationMode:kCAAnimationCubic];
//        [pathAnimation setFillMode:kCAFillModeForwards];
//        pathAnimation.duration = 14.0;
//
//        [MY_VIEW.layer addAnimation:pathAnimation forKey:nil];
        
//        var angel : Int = 0 // start angle position 0-360 deg
//        let center : CGPoint = pm25CircleView.center
//        let radious = Double((pm25CircleView.frame.size.width-30)/2)
//
//        var startPoint : CGPoint = self.setPointToAngle(angle: angel, centerPoint: center, radius: radious)
//
//
//        let path : CGMutablePath = CGMutablePath()
//            path.move(to: CGPoint(x: startPoint.x, y:startPoint.y))
//        var expPoint :CGPoint!
//        for index in 1...4{
//
//            angel = angel + 30
//            expPoint = self.setPointToAngle(angle: angel, centerPoint: center, radius: radious)
//            angel = angel + 30
//
//            startPoint = self.setPointToAngle(angle: angel, centerPoint: center, radius: radious)
//
//            path.addPath(path)
//            path.addQuadCurve(to: CGPoint(x: expPoint.x, y: expPoint.y), control: CGPoint(x: startPoint.x, y: startPoint.y))
//        }
//
//                    let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
//                    animation.duration = 10
//                    animation.repeatCount = 1
//                    animation.path = path
//                    polutionArrow.layer.add(animation, forKey: nil)
        
        
        
        
     
//        for index in 1...360{
//
//
//
//        }
        
    }
    
    
//    func setPointToAngle(angle :Int,centerPoint :CGPoint,radius:Double)-> CGPoint{
//
//        let sin : CGFloat = CGFloat(radius*sindeg(degrees:Double(angle)))
//        let cos : CGFloat = CGFloat(radius*cosdeg(degrees:Double(angle)))
//        return CGPoint(x: cos + centerPoint.x, y: sin + centerPoint.y)
//
//    }
//    func sindeg(degrees: Double) -> Double {
//        return sin(degrees / 180.0 * .pi)
//    }
//    func cosdeg(degrees: Double) -> Double {
//        return sin(degrees / 180.0 * .pi)
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressLabel.text = appDelegate.currentAddress
//
//        let circlePath = UIBezierPath(arcCenter: pm25CircleView.center, radius: (pm25CircleView.frame.size.width-30)/2, startAngle: 2, endAngle: 8, clockwise: true)
//
//        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
//        animation.duration = 50
//        animation.repeatCount = 1
//        animation.path = circlePath.cgPath
//        polutionArrow.layer.add(animation, forKey: nil)
//        polutionArrow.frame.origin = CGPoint(x: circlePath.currentPoint.x-10, y: circlePath.currentPoint.y-10)
        
        let point  : Float = (180)/180

        print(CGFloat.pi)
        UIView.animate(withDuration: 5) { () -> Void in
            self.animationView1.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
//        UIView.animate(withDuration: 5, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
//            self.animationView1.transform = CGAffineTransform(rotationAngle: CGFloat.pi*2)
//        }, completion: nil)
        
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


