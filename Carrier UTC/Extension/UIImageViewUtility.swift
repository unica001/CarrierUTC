//
//  UIImageViewUtility.swift
//  Library
//
//  Created by Shilpa Sharma on 19/11/18.
//  Copyright © 2018 Shilpa Sharma. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func roundImage() {
        self.layer.cornerRadius = self.frame.size.width / 2.0;
        self.layer.masksToBounds = true;
    }
    
    func setImageWith(strImage: String?, placeHolderImage: UIImage? = nil) {
        self.sd_setImage(with:URL(string: strImage ?? "") , placeholderImage: placeHolderImage, options:.cacheMemoryOnly, completed: nil)
    }
}
