//
//  CellBlog.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 29/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

protocol BlogDelegate: class {
    func tapRead(_ sender: UIButton)
    func tapFacebook(_ sender: UIButton)
    func tapInstagram(_ sender: UIButton)
}

class CellBlog: UITableViewCell {

    weak var delegate: BlogDelegate!
    @IBOutlet weak var imgBlog: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHead: UILabel!
    @IBOutlet weak var btnRead: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpBlog(blogData: BlogModel) {
        imgBlog.setImageWith(strImage: blogData.event_image)
        lblHead.text = blogData.heading
        lblDesc.text = blogData.desc
        //2018-11-21T07:25:11.734Z
//        let date = Helper.stringToDate(strDate: blogData.create_date!, format: "yyyy-MM-dd")
        lblDate.text = blogData.create_date//date.dateWithString(strFormat: "dd mm, yyyy")
    }
    
    @IBAction func tapRead(_ sender: UIButton) {
        if delegate != nil {
            self.delegate.tapRead(sender)
        }
    }
    @IBAction func tapfacebook(_ sender: UIButton) {
        if delegate != nil {
            self.delegate.tapFacebook(sender)
        }
    }
    @IBAction func tapInstagram(_ sender: UIButton) {
        if delegate != nil {
            self.delegate.tapInstagram(sender)
        }
    }
}
