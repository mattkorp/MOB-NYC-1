//
//  WebViewController.swift
//  REST
//
//  Created by Rudd Taylor on 2/25/15.
//  Copyright (c) 2015 ga. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    var request: NSURLRequest?
    
    override func viewDidLoad() {
        if let request = self.request {
            self.webView.loadRequest(request)
        }
    }
}
