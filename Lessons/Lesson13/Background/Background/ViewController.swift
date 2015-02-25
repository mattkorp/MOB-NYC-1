//
//  ViewController.swift
//  Background
//
//  Created by Rudd Taylor on 2/18/15.
//  Copyright (c) 2015 ga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backgroundSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.backgroundSwitch.addTarget(self, action: "didChangeSwitch", forControlEvents: UIControlEvents.ValueChanged)
        
        self.backgroundSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey("switchIsOn")
        didChangeSwitch()
        if let path = NSBundle.mainBundle().pathForResource("Athletes", ofType: "plist") {
            var array = NSArray(contentsOfFile: path)
            println(array)
            array?.writeToFile(path, atomically: true)
        }

    }
    
    func didChangeSwitch() {
        if self.backgroundSwitch.on {
            self.label.font = UIFont.systemFontOfSize(30)
        } else {
            self.label.font = UIFont.systemFontOfSize(10)
        }
        NSUserDefaults.standardUserDefaults().setBool(self.backgroundSwitch.on, forKey: "switchIsOn")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

