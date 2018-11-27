//
//  Enumeration.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import Foundation

enum EventType: String {
    case Upcoming = "Upcoming Events"//"UPCOMING EVENTS"
    case Past = "Past Events"//"PAST EVENTS"
    case Search = "Search Events"//"SEARCH EVENTS"
}

enum RegisterType {
    case Name
    case Phone
    case Email
    case Submit
}

enum ContentUrl: String {
    case Privacy = "http://103.91.90.242:8000/api/privacy-policy"
    case About = "http://www.google.com"
    case Terms = "http://www.apple.com"
}
