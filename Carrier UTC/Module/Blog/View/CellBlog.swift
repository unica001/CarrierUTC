//
//  CellBlog.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 29/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class CellBlog: UITableViewCell {

    @IBOutlet weak var imgBlog: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHead: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
