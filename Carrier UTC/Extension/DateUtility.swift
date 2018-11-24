//
//  DateUtility.swift
//  Library
//
//  Created by Shilpa Sharma on 19/11/18.
//  Copyright © 2018 Shilpa Sharma. All rights reserved.
//

import Foundation

extension Date {
    
    public func dateWithString(strFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = strFormat
        return dateFormatter.string(from: self)
    }
    
    public func localDate() -> Date {
        if let timeZone = TimeZone(abbreviation: "UTC") {
            let seconds = TimeInterval(timeZone.secondsFromGMT(for: self))
            return Date(timeInterval: seconds, since: self)
        }
        return self
    }
    
    // or GMT time
    func utcDate() -> Date {
        
        if let timeZone = TimeZone(abbreviation: "UTC") {
            let seconds = -TimeInterval(timeZone.secondsFromGMT(for: self))
            return Date(timeInterval: seconds, since: self)
        }
        return self
    }
    
    public func relativePast() -> String
    {
        let todayDate = NSDate(timeIntervalSince1970:ConstantTime.Time().nowTime())
        
        let units = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second,.timeZone, .weekOfYear])
        
        let components = Calendar.current.dateComponents(units, from: self, to: todayDate as Date)
        
        if components.year! > 0 {
            let strTime = "\(components.year!) " + (components.year! > 1 ?"years ago"  : "year ago")
            return strTime
        } else if components.month! > 0 {
            let strTime = "\(components.month!) " + (components.month! > 1 ? "months ago": "month ago")
            return strTime
        } else if components.weekOfYear! > 0 {
            let strTime = "\(components.weekOfYear!) " + (components.weekOfYear! > 1 ? "weeks ago" : "week ago")
            return strTime
        } else if (components.day! > 0) {
            let strTime = (components.day! > 1 ? "\(components.day!) days ago" :"Yesterday")
            return strTime
        } else if components.hour! > 0 {
            let strTime = "\(components.hour!) " + (components.hour! > 1 ? "hours ago" : "hour ago")
            return strTime
        } else if components.minute! > 0 {
            let strTime = "\(components.minute!) " + (components.minute! > 1 ?"mins ago" : "min ago")
            return strTime
        } else {
            let strTime = NSLocalizedString("Just now", comment: "")
            return strTime
        }
    }
}

class ConstantTime {
    struct Time {
        let nowTime = { round(Date().timeIntervalSince1970) } // seconds
    }
}
