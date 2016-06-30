//
//  NewsCategoriesController.swift
//  NewsReader
//
//  Created by Shivi on 6/27/16.
//  Copyright © 2016 NaviSpin. All rights reserved.
//

import UIKit

class NewsCategoriesController: UIViewController, UITableViewDataSource, UITableViewDelegate, BackButtonPressDelegate {

    @IBOutlet var tableView: UITableView!
    
    let textCellIdentifier = "newsCat"
    var pressBackButton: Bool?
    
    let newsCats = ["Top Stories", "World", "Business", "Technology", "Health", "Sports"]
    let newsCatsUrls = ["home", "world", "business", "technology", "health", "sports"]
    var origBarButton: UIBarButtonItem?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView() // removes blank cells at bottom
        self.edgesForExtendedLayout = UIRectEdge.None // aligns cells to the top
        self.tableView.contentInset = UIEdgeInsetsMake(0, -15, 0, 0); // left align the table view
        
        
        // self.navigationController?.navigationBar.backItem?.title = "Section2";
        
        // self.navigationItem.title = "Hello";
        print("FROM BACK BUTTON")
        origBarButton = self.navigationItem.backBarButtonItem
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil);
        
        // Do any additional setup after loading the view, typically from a nib.
        // data_request()
        
        tableView.hidden = true;
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        
        
        let destination = storyboard.instantiateViewControllerWithIdentifier("NewsItemsController") as! ViewController
        destination.newsCategory = self.newsCats[0]
        destination.newsCategoryUrl = self.newsCatsUrls[0]
        navigationController?.pushViewController(destination, animated: true)

        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        print("VIEW APPEARED FROM BACK")
        self.navigationItem.title = "Sections";
        self.navigationItem.backBarButtonItem = origBarButton
        tableView.hidden = false
        // self.navigationItem.backBarButtonItem
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCats.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = self.newsCats[row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        let row = indexPath.row
        
        
        let destination = storyboard.instantiateViewControllerWithIdentifier("NewsItemsController") as! ViewController
        destination.newsCategory = self.newsCats[row]
        // destination.newsURL = self.newsItems[row].newsUrl
        destination.newsCategoryUrl = self.newsCatsUrls[row]
        navigationController?.pushViewController(destination, animated: true)
        
    }
    
    func didPressBackButton(didPress: Bool) {
        pressBackButton = didPress;
        // tableView.hidden = false;
        // self.tableView.reloadData();
    }
}
