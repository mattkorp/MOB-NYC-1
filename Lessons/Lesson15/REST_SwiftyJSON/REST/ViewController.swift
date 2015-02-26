//
//  ViewController.swift
//  REST
//
//  Created by Rudd Taylor on 2/25/15.
//  Copyright (c) 2015 ga. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    var json: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        if let url = NSURL(string: "http://www.reddit.com/.json") {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                self.json = JSON(data: data)
                // Required! We must update the UI only on the main queue, but this completion handler gets run in the background queue!
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            })
            // Required to start the network task
            task.resume()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let json = self.json {
            return json["data"]["children"].arrayValue.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        if cell == nil  {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        
        if let json = self.json {
            cell.textLabel?.text = json["data"]["children"][indexPath.row]["data"]["title"].stringValue
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let json = self.json {
            if let url = NSURL(string: "http://reddit.com" + json["data"]["children"][indexPath.row]["data"]["permalink"].stringValue) {
                performSegueWithIdentifier("web", sender: NSURLRequest(URL: url))
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let request = sender as? NSURLRequest {
            var destinationViewController = segue.destinationViewController as WebViewController
            destinationViewController.request = request
        }
    }
}

