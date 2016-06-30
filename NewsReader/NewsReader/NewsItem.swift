//
//  NewsItem.swift
//  NewsReader
//
//  Created by Shivi on 5/18/16.
//  Copyright © 2016 NaviSpin. All rights reserved.
//

import Foundation

class NewsItem {
    var title: String?
    var byLine: String?
    var imageUrl: String?
    var newsUrl: String?
    
    init(newsItem: Dictionary<String, AnyObject>) {
        
        guard let title1 = newsItem["title"] as? String,
            let byLine1 = newsItem["byline"] as? String,
        let newsUrl1 = newsItem["url"] as? String
            else { return }
        
        self.title = title1
        self.byLine = byLine1
        self.newsUrl = newsUrl1
       // print("Title  + \(title)")
        
        guard
            // let media = newsItem["media"] as? [[String: AnyObject]] else { self.imageUrl = "FOO"; return; }
            // let mediaMeta = media[0]["media-metadata"] as? [[String: AnyObject]]
            let media = newsItem["multimedia"] as? [[String: AnyObject]] else { self.imageUrl = "FOO"; return; }
        if(media.count > 0) { self.imageUrl = media[0]["url"] as? String; }
        else { self.imageUrl = "FOO" }
        
           // print("MEDIA + \(media)");
        // self.imageUrl = media[0]["url"] as? String;
        
       // print("IMAGE URL \(self.imageUrl)");
        
    }
}
