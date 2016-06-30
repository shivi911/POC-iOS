//
//  NewsDetailController.swift
//  NewsReader
//
//  Created by Shivi on 5/19/16.
//  Copyright © 2016 NaviSpin. All rights reserved.
//

import UIKit

class NewsDetailController: UIViewController {

    @IBOutlet var newsWebView: UIWebView!
    
    var newsURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL (string:newsURL!);
        let requestObj = NSURLRequest(URL: url!);
        newsWebView.loadRequest(requestObj);
        
        // print("NEWS URL IS: \(newsURL)");
    }

}
