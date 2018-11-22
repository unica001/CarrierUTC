//
//  CellEvent.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class CellEvent: UICollectionViewCell {

    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var viewEvent: UIView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblEventAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpEventGradient() {
        let colorBottom = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, colorBottom, colorBottom]
        gradientLayer.locations = [0, 0.1, 0.9, 1]
        gradientLayer.frame = self.bounds
        viewEvent.layer.mask = gradientLayer
    }
    
}
