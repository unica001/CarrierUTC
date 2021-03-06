//
//  CellEventDetail.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class CellEventDetail: UITableViewCell {

    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblEventAddress: UILabel!
    @IBOutlet weak var lblPeople: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewDate.roundCorners(borderWidth: 1, borderColor: UIColor.black.cgColor, cornerRadius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setEventDetail(event: EventModel) {
        lblEventName.text = event.heading
        lblEventAddress.text = event.event_address
        lblDesc.text = event.event_description
        lblPeople.text = "\(String(describing: event.interested_users!)) people going"
        
       
        let date = Helper.stringToDate(strDate: event.event_date!, format: "yyyy-MM-dd")
        let eventDate = date.dateWithString(strFormat: "dd")
        let eventMonth = date.dateWithString(strFormat: "MMM")
        let newMonth = "\(eventMonth)\n"
        
        let dateAttributes = [NSAttributedString.Key.font: UIFont.font(name: .OpenSans, weight: .Bold, size: .size_14),
                              NSAttributedString.Key.foregroundColor: UIColor.black]
        let monthAttributes = [NSAttributedString.Key.font: UIFont.font(name: .OpenSans, weight: .SemiBold, size: .size_8),
                               NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let dateMonthStr: NSMutableAttributedString = NSMutableAttributedString()
        let dateStr = NSAttributedString(string: eventDate, attributes: dateAttributes)
        let monthStr = NSAttributedString(string: newMonth, attributes: monthAttributes)
        dateMonthStr.append(monthStr)
        dateMonthStr.append(dateStr)
        lblEventDate.attributedText = dateMonthStr
    }
}
