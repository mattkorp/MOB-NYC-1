//
//  ThirdViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO three: Save the text in this text box to a flat file when 'next' is pressed.
        
        let docsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = docsDirectory.stringByAppendingPathComponent("string.plist")
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(path) {
            fileManager.createFileAtPath(path, contents: nil, attributes: nil)
        } else {
            if let bundle: NSString = NSBundle.mainBundle().pathForResource("string", ofType: "plist") {
                fileManager.copyItemAtPath(bundle as String, toPath: path, error: nil)
            }
        }
        let string = NSString(string: textView.text as NSString)
        string.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: nil)

        
        //        if let documentPath = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as? NSURL {
//            let path = documentPath.url
//            if fileManager.fileExistsAtPath(path)
//            let filePath = documentPath.URLByAppendingPathComponent("file.plist", isDirectory: false)
//            
//            if let string = NSBundle.mainBundle().pathForResource("file", ofType: "plist") {
//                let text = textView.text
//                let result = text.writeToFile(string, atomically: true, encoding: NSStringEncoding()., error: <#NSErrorPointer#>)
//                println(result)
//            }
//        }
    }
}
