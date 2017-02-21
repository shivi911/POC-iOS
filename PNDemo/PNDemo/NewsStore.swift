//
//  NewsStore.swift
//  PNDemo
//
//  Created by Shivi on 2/17/17.
//  Copyright © 2017 NaviSpin. All rights reserved.
//

import UIKit

class NewsStore: NSObject {
    static let sharedStore = NewsStore()
    
    var items: [NewsItem] = []
    
    override init() {
        super.init()
        self.loadItemsFromCache()
    }
    
    func addItem(newItem: NewsItem) {
        items.insert(newItem, at: 0)
        saveItemsToCache()
    }
}

// MARK: Persistance
extension NewsStore {
    func saveItemsToCache() {
        print("SAVING")
        NSKeyedArchiver.archiveRootObject(items, toFile: itemsCachePath)
        loadItemsFromCache()
    }
    
    func loadItemsFromCache() {
        print("LOADING")
        if let cachedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemsCachePath) as? [NewsItem] {
            items = cachedItems
        }
        print("LOAD ITEMS: \(items.count)")
    }
    
    var itemsCachePath: String {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fUrl = documentsURL.appendingPathComponent("news.dat", isDirectory: true)
        
        return fUrl.path
    }
}
