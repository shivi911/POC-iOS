//
//  DateParser.swift
//  PNDemo
//
//  Created by Shivi on 2/19/17.
//  Copyright © 2017 NaviSpin. All rights reserved.
//

import UIKit

class DateParser: NSObject {
    
    static let dateFormatter = { (void) -> DateFormatter in
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale!
        return formatter
    }()
    
    //Wed, 04 Nov 2015 21:00:14 +0000
    static func dateWithPodcastDateString(dateString: String) -> NSDate? {
        dateFormatter.dateFormat = "EEE, dd, MMM yyyy HH:mm:ss Z"
        return dateFormatter.date(from: dateString) as NSDate?
    }
    
    static func displayString(fordate date: NSDate) -> String {
        print("DATE FORMAT: \(date)")
        dateFormatter.dateFormat = "HH:mm MMMM dd, yyyy"
        return dateFormatter.string(from: date as Date)
    }


}
