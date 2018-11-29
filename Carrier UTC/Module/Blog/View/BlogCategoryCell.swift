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
    @IBOutlet weak var viewMain: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpBlogCategory(category : BlogCategoryModel) {
        lblCategory.text = category.name
        lblNoOfBlog.text = "\(String(describing: category.blog_count!))"
        imgCategory.setImageWith(strImage: category.image)
        viewMain.backgroundColor = UIColor.colorWith(hexString: category.color_code!)
    }
    
}
