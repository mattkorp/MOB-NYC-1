//
//  SecondViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var settingsField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO two: Make this text view print the values of the string and slider value stored in the settings bundle of the app.
        
        // note: does not grab default values. must change them to read.
        let defaults = NSUserDefaults.standardUserDefaults()
        let sliderValue = defaults.doubleForKey("settings_slider")
        if let stringValue: String = defaults.stringForKey("settings_name") {
            self.settingsField.text = "\(sliderValue) \(stringValue)"
        }
    }
}
