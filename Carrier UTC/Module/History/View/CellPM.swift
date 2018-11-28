//
//  CellPM.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 28/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class CellPM: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblMin.roundCorners(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 4)
        lblMax.roundCorners(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 4)
    }

    func setUpTowerInfo(towerInfo: PMTowerModel) {
        lblMin.text = "\(String(describing: towerInfo.minimum!))"
        lblMax.text = "\(String(describing: towerInfo.maximum!))"
        lblMax.backgroundColor = UIColor.colorWith(hexString: towerInfo.color_max!)
        lblMin.backgroundColor = UIColor.colorWith(hexString: towerInfo.color_min!)
        let date = Helper.stringToDate(strDate: towerInfo.date!, format: "dd-MM-yyyy")
        let day = date.dayOfWeek()
        lblDays.text = day
    }
    
}
