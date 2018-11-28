//
//  CellHistory.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 28/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class CellHistory: UITableViewCell {
    @IBOutlet weak var collectionScale: UICollectionView!
    
    @IBOutlet weak var maxWidthCnst: NSLayoutConstraint!
    @IBOutlet weak var minWidthCnst: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
