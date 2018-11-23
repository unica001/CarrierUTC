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
    }
    
}
