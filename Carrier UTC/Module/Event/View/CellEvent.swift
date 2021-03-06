//
//  CellEvent.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class CellEvent: UICollectionViewCell {

    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var viewEvent: UIView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblEventAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
    }

    func setUpEventGradient() {
        let colorBottom = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, colorBottom, colorBottom]
        gradientLayer.locations = [0, 0.1, 0.9, 1]
        gradientLayer.frame = self.bounds
        viewEvent.layer.mask = gradientLayer
    }
    
    func setUpEventList(event: EventModel) {
        setUpEventGradient()
        lblEventName.text = event.heading
        lblEventAddress.text = event.event_address
        imgEvent.setImageWith(strImage: event.event_image)
        //2018-11-18
       
        let date = Helper.stringToDate(strDate: event.event_date!, format: "yyyy-MM-dd")
        let eventDate = date.dateWithString(strFormat: "dd")
        let eventMonth = date.dateWithString(strFormat: "MMM")
        let newMonth = "\(eventMonth)\n"
        
        let dateAttributes = [NSAttributedString.Key.font: UIFont.font(name: .OpenSans, weight: .Bold, size: .size_15),
                              NSAttributedString.Key.foregroundColor: UIColor.white]
        let monthAttributes = [NSAttributedString.Key.font: UIFont.font(name: .OpenSans, weight: .SemiBold, size: .size_11),
                                NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let dateMonthStr: NSMutableAttributedString = NSMutableAttributedString()
        let dateStr = NSAttributedString(string: eventDate, attributes: dateAttributes)
        let monthStr = NSAttributedString(string: newMonth, attributes: monthAttributes)
        dateMonthStr.append(monthStr)
        dateMonthStr.append(dateStr)
        lblEventDate.attributedText = dateMonthStr
    }
    
}
