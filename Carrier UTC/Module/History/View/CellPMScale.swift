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
        viewMain.roundCorners(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: viewMain.frame.size.height/2)
    }

}
