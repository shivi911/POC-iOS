//
//  NewsItem.swift
//  PNDemo
//
//  Created by Shivi on 2/17/17.
//  Copyright © 2017 NaviSpin. All rights reserved.
//

import UIKit

final class NewsItem: NSObject {
    let title: String
    let date: NSDate
    let isRead: Bool
    
    init(title: String, date: NSDate, isRead: Bool) {
        self.title = title
        self.date = date
        self.isRead = isRead
    }
}

extension NewsItem: NSCoding {
    struct CodingKeys {
        static let Title = "title"
        static let Date = "date"
        static let IsRead = "isRead"
    }
    
    convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: CodingKeys.Title) as? String
        let date = aDecoder.decodeObject(forKey: CodingKeys.Date) as? NSDate
        let isRead = aDecoder.decodeBool(forKey: CodingKeys.IsRead)
        self.init(title: title!, date: date!, isRead: isRead)
        /*
        if let title = aDecoder.decodeObject(forKey: CodingKeys.Title) as? String,
            let date = aDecoder.decodeObject(forKey: CodingKeys.Date) as? NSDate,
            let isRead = aDecoder.decodeObject(forKey: CodingKeys.IsRead) as? Bool {
            self.init(title: title, date: date, isRead: isRead)
        } else {
            return nil
        }
 */
    }
        
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: CodingKeys.Title)
        aCoder.encode(date, forKey: CodingKeys.Date)
        aCoder.encode(isRead, forKey: CodingKeys.IsRead)
    }

}
