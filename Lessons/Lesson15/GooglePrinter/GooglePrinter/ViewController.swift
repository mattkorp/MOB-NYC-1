//
//  ViewController.swift
//  GooglePrinter
//
//  Created by Rudd Taylor on 2/25/15.
//  Copyright (c) 2015 ga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        if let url = NSURL(string: "http://google.com") {
            webView.loadRequest(NSURLRequest(URL: url))
        } else {
            let alert = UIAlertView(title: "Bad URL", message: nil, delegate: self, cancelButtonTitle: "Cancel")
            alert.show()
        }
        
        
//            let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
//                var string = ""
//                if let e = error {
//                    string = e.userInfo!.debugDescription
//                } else {
//                    string = NSString(data: data, encoding: NSUTF8StringEncoding)!
//                    println(string)
//                }
//                dispatch_async(dispatch_get_main_queue(), {
//                    self.textView.text = string
//                })
//            })
//            task.resume()
//        }
    }


}

