//
//  ViewController.swift
//  Files
//
//  Created by Rudd Taylor on 2/18/15.
//  Copyright (c) 2015 ga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let documentPath = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as? NSURL {
            if let string = NSBundle.mainBundle().pathForResource("file", ofType: "plist") {
                let array = NSArray(contentsOfFile: string)
                
                println(array)
            }
            let filePath = documentPath.URLByAppendingPathComponent("file.plist", isDirectory: false)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

