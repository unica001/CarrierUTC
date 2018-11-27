//
//  CellSubmit.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 26/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

protocol SubmitDelegate: class {
    func tapSubmit(sender: UIButton)
    func tapTermsAccept(sender: UIButton)
    func tapTerms(sender: UIButton)
}

class CellSubmit: UITableViewCell {

    weak var delegate: SubmitDelegate!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnTerms: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnSubmit.roundCorners(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: btnSubmit.bounds.size.height/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Methods
    
    func setUpData(data: RegisterStruct) {
        if let isTerms = data.isTerms, isTerms == true {
             btnTerms.isSelected = true
        } else {
            btnTerms.isSelected = false
        }
    }
    
    //MARK: - IBAction
    @IBAction func tapSubmit(_ sender: UIButton) {
        if self.delegate != nil {
            self.delegate.tapSubmit(sender: sender)
        }
    }
    @IBAction func tapTerms(_ sender: UIButton) {
        if self.delegate != nil {
            self.delegate.tapTermsAccept(sender: sender)
        }
    }
    @IBAction func tapTermsCondition(_ sender: UIButton) {
        if self.delegate != nil {
            self.delegate.tapTerms(sender: sender)
        }
    }
}
