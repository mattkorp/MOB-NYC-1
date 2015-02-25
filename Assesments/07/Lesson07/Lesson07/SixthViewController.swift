
//
//  SixthViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class SixthViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO six: Read the array saved in the previous file and print its space-delimited string representation here.
    
        let docsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = docsDirectory.stringByAppendingPathComponent("array.plist")
        if let array = NSArray(contentsOfFile: path) {
            if let string = array.valueForKey("description")?.componentsJoinedByString(" ") {
            textView.text = String(string)
            }
        }
    }
}
