//
//  TipsCell.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 29/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class TipsCell: UICollectionViewCell {

    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var imgTip: UIImageView!
    @IBOutlet weak var viewLine: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgTip.layer.cornerRadius = imgTip.frame.size.width/2
        imgTip.layer.masksToBounds = true
    }
    
    func setUPTips(healthData: HealthPrecaution, index: Int, totalCount: Int) {
        imgTip.setImageWith(strImage: healthData.preference_image)
        lblTip.text = healthData.preference_text
        viewLine.isHidden = (index == (totalCount-1)) ? true : false
    }

}
