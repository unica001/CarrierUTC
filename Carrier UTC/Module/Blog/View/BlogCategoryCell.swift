//
//  BlogCategoryCell.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class BlogCategoryCell: UITableViewCell {
    //MARK: - IBOutlet
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblNoOfBlog: UILabel!
    @IBOutlet weak var imgCategory: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
