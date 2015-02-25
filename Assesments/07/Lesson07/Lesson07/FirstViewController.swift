//
//  FirstViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit
import Foundation

class FirstViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO one: Make this text view print the values of test_string and test_number, stored in NSUserDefaults
        let defaults = NSUserDefaults.standardUserDefaults()
        if let test_string = defaults.stringForKey("test_string") {
            let test_number = defaults.integerForKey("test_number")
                self.textField.text = "\(test_number) \(test_string)"            
        }

    }
}