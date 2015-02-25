//
//  FourthViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO four: Read the file saved in the previous TODO, and make this text box print out the text of that file.
        
        let docsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = docsDirectory.stringByAppendingPathComponent("string.plist")
        if let string = NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil) {
            textView.text = string as String
        }
    }
}
