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
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var circleViewHeight: NSLayoutConstraint!
    @IBOutlet weak var polutionArrow: UIImageView!
    
    internal var viewModel : HomeModelling!
    
    var appDelegate : AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewHeader.roundCorners(borderWidth: 1, borderColor: UIColor.clear.cgColor, cornerRadius: 5)
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        circleViewHeight.constant = self.view.frame.size.width/2
        
        setUp()
        UIView.animate(withDuration: 0.5, animations: {
            self.polutionArrow.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi)))
        }) { (isAnimationComplete) in
            // Animation completed
        }
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
            print(health_precaution)
            print(PM10)
            print(PM25)
            }

            
        })
    }
    @IBAction func testrButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: kairQualitySegueIdentifier, sender: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressLabel.text = appDelegate.currentAddress

    }
 
}
extension UIView {
    
    func startRotation() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = NSNumber(value: Double.pi)
        rotation.duration = 1.0
        rotation.isCumulative = true
        rotation.repeatCount = FLT_MAX
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func stopRotation() {
        self.layer.removeAnimation(forKey: "rotationAnimation")
    }
}
