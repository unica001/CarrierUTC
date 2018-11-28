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
        lblMin.roundCorners(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 10)
        lblMax.roundCorners(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 10)
    }

}
