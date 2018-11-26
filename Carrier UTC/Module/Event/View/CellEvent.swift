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
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: event.event_date!)
        let eventDate = date?.dateWithString(strFormat: "dd")
        let eventMonth = date?.dateWithString(strFormat: "MMM")
        let newDate = "\(eventDate!)\n"
        
        let dateAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                              NSAttributedString.Key.foregroundColor: UIColor.white]
        let monthAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                                NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let dateMonthStr: NSMutableAttributedString = NSMutableAttributedString()
        let dateStr = NSAttributedString(string: newDate, attributes: dateAttributes)
        let monthStr = NSAttributedString(string: eventMonth!, attributes: monthAttributes)
        dateMonthStr.append(dateStr)
        dateMonthStr.append(monthStr)
        lblEventDate.attributedText = dateMonthStr
    }
    
}
