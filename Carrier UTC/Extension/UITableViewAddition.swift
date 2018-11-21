//
//  UITableViewAddition.swift
//  Library
//
//  Created by Shilpa Sharma on 19/11/18.
//  Copyright © 2018 Shilpa Sharma. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    // Register nib on UITableView...
    func register(nib nibName:String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: nibName)
    }
    
    // Register multiple nib at once
    func registerMultiple(nibs arrayNibs:[String]) {
        for nibName in arrayNibs {
            register(nib: nibName)
        }
    }
    
    func hideEmptyCells() {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = .zero
        self.tableFooterView = view
    }
    
    func scrollToTop(animation: Bool) {
        if self.tableHeaderView != nil {
            self.setContentOffset(.zero, animated: animation)
        } else {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: animation)
        }
    }
    
    func scrollToBottom(animation: Bool) {
        
        let section = self.numberOfSections - 1
        let lastRow = self.numberOfRows(inSection: section) - 1
        if section >= 0, lastRow >= 0 {
            let indexPath = IndexPath(row: lastRow, section: section)
            self.scrollToRow(at: indexPath, at: .top, animated: animation)
        }
    }
}
