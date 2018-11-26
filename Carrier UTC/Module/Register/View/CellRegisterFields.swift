//
//  CellRegisterFields.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 26/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class CellRegisterFields: UITableViewCell {

    @IBOutlet weak var txtField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtField.roundCorners(borderWidth: 0.5, borderColor: UIColor.lightGray.cgColor, cornerRadius: txtField.bounds.size.height/2)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpData(regiter: RegisterStruct) {
        txtField.placeholder = regiter.placeholder
        txtField.text = regiter.value
        txtField.setLeftPadding(arrayTxt: [txtField], margin: 10)
        if regiter.type == RegisterType.Name {
            txtField.keyboardType = .default
        } else if regiter.type == RegisterType.Phone {
            txtField.keyboardType = .phonePad
        } else if regiter.type == RegisterType.Email {
            txtField.keyboardType = .emailAddress
        }
    }
    
}
