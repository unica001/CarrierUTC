//
//  CellPMScale.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 28/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class CellPMScale: UICollectionViewCell {
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lbl25Scale: UILabel!
    @IBOutlet weak var lbl10Scale: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width/2
        self.layer.masksToBounds = true
    }
    
    func setUpScaleInfo(scaleInfo: PMScaleModel?, index: Int) {
        if index == 0 {
            lbl25Scale.text = "PM 2.5"
            lbl10Scale.text = "PM 10"
            lblResult.text = "RESULTS"
            lblResult.textColor = UIColor.darkGray
            lbl25Scale.textColor = UIColor.darkGray
            lbl10Scale.textColor = UIColor.darkGray
            viewMain.backgroundColor = UIColor.lightGray
        } else {
            lbl25Scale.text = scaleInfo?.pm25_value
            lbl10Scale.text = scaleInfo?.pm10_value
            lblResult.text = scaleInfo?.name
            let color = UIColor.colorWith(hexString:(scaleInfo?.color_code)!)
            lblResult.textColor = color
            lbl10Scale.textColor = UIColor.white
            lbl25Scale.textColor = UIColor.white
            viewMain.backgroundColor = color
        }
    }

}
