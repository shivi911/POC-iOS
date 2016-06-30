//
//  ViewController.swift
//  NewsReader
//
//  Created by Shivi on 5/18/16.
//  Copyright © 2016 NaviSpin. All rights reserved.
//

import UIKit

protocol BackButtonPressDelegate {
    func didPressBackButton(didPress:Bool)
}

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var newsCategory: String? // category selected
    var newsCategoryUrl: String? // category selected
    var delegate: BackButtonPressDelegate?
    
    
    var newsItems = [NewsItem]()
    var currOffset = 0
    var actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView

    @IBOutlet var tableView: UITableView!
    
    let textCellIdentifier = "newsItem"
    
    let swiftBlogs = ["Ray Wenderlich", "NSHipster", "iOS Developer Tips", "Jameson Quave", "Natasha The Robot", "Coding Explorer", "That Thing In Swift", "Andrew Bancroft", "iAchieved.it", "Airspeed Velocity"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.title = newsCategory;
        
        
        
     
        // Do any additional setup after loading the view, typically from a nib.
        data_request()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated : Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParentViewController()) {
            self.delegate?.didPressBackButton(true);
            print("PRESSED BACK BUTTON");
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return [[self.swiftBlogs objectAtIndex:section], count];
        // return swiftBlogs.count;
        return newsItems.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)
        
        cell.shouldIndentWhileEditing  = false;
        
        let row = indexPath.row
       // print("TITLE ISSS \(self.newsItems[row].title)")
        // cell.textLabel?.text = swiftBlogs[row]
        
        cell.textLabel?.text = self.newsItems[row].title
        cell.detailTextLabel?.text = self.newsItems[row].byLine
          
    // load images asynchronously
        // http://jamesonquave.com/blog/developing-ios-apps-using-swift-part-5-async-image-loading-and-caching/
    
        let imgUrl = self.newsItems[row].imageUrl
        
        if(imgUrl == "FOO") {
            print("IMAGE URL IS \(imgUrl)")
            cell.imageView?.image = UIImage(named: "Blank52")
        
        }
        else {
            loadImage(NSURL(string: imgUrl!)!, indexPath: indexPath)
        }
        
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        let row = indexPath.row
        
        
            let destination = storyboard.instantiateViewControllerWithIdentifier("NewsDetailController") as! NewsDetailController
        destination.newsURL = self.newsItems[row].newsUrl
            navigationController?.pushViewController(destination, animated: true)
        
    }
    
    /*
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        print("ROW IS \(row)")
        if(row+1 == newsItems.count) {
            // cell.textLabel?.text = "Loading ..."
            // https://ioswift.wordpress.com/2014/06/08/uiactivityindicatorview-in-swift/
            actInd.center = self.view.center
            actInd.hidesWhenStopped = true
            actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(actInd)
            actInd.startAnimating()
            
        print("NEED TO LOAD MORE")
            data_request()
        }
        
    }
*/
        
    func data_request()
    {
        let offset :Int = newsItems.count
        
       // let url_to_request = "http://api.nytimes.com/svc/mostpopular/v2/mostemailed/all-sections/1.json?api-key=fa5723452d7d2454cf24a2a3d920012c:10:66680873&offset=0"
        
       // let url_to_request = "http://api.nytimes.com/svc/mostpopular/v2/mostemailed/all-sections/1.json?api-key=fa5723452d7d2454cf24a2a3d920012c:10:66680873&offset=" + String(offset)
        
        let url_to_request = "http://api.nytimes.com/svc/topstories/v2/home.json?api-key=fa5723452d7d2454cf24a2a3d920012c:10:66680873"
        var url1 = "http://api.nytimes.com/svc/topstories/v2/";
        url1 += self.newsCategoryUrl!;
        url1 += ".json?api-key=fa5723452d7d2454cf24a2a3d920012c:10:66680873";
        
        
        // let url:NSURL = NSURL(string: url_to_request)!
        print("URL IS \(url1)");
        let url:NSURL = NSURL(string: url1)!
        let session = NSURLSession.sharedSession()

        
        let task = session.dataTaskWithURL(url) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
           // print(dataString)
            
            // https://devdactic.com/rest-api-parse-json-swift/
            
            // http://code.tutsplus.com/tutorials/working-with-json-in-swift--cms-25335
            do {
                let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    self.readJSONObject(dictionary)
                }
            } catch {
                print("ERROR IN JSON")
            }
            
            
        }
        
        task.resume()
        
    }
    
    func readJSONObject(object: [String: AnyObject]) {
        
        guard
            let newsLists = object["results"] as? [[String: AnyObject]] else { return }
        // _ = "Swift \(version) " + title
        
        for newsItem in newsLists {
            let news = NewsItem(newsItem:newsItem);
            newsItems.append(news);
           // print(newsItems.count);
            
        }
        print("# OF NEWS ITEMS \(newsItems.count)");
        dispatch_async(dispatch_get_main_queue(),{
            self.tableView.reloadData()
            
            self.actInd.stopAnimating()
            self.actInd.removeFromSuperview()
        })
        
        
    }
    
    func loadImage(imgURL: NSURL, indexPath: NSIndexPath) {
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        let mainQueue = NSOperationQueue.mainQueue()
        // NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler:
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(imgURL)
            { (let data, let response, let error) in
                
                
                if error == nil {
                    // Convert the downloaded data in to a UIImage object
                    let image = UIImage(data: data!)
                    // Store the image in to our cache
                    // self.imageCache[urlString] = image
                    // Update the cell
                    
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        if let cellToUpdate = self.tableView.cellForRowAtIndexPath(indexPath) {
                            cellToUpdate.imageView?.image = image
                            
                            cellToUpdate.layoutSubviews()
                            // self.tableView.reloadData()
                        }
                    })
                    
                }
                else {
                    print("Error with image + URL is \(imgURL)")
                }
        }
        
        task.resume()
    }
    
    

}

