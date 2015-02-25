//
//  FifthViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController{

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO Five: Strings can be entered into this text box in a space-delimited fashion. They represent an array of strings. E.g. the entry "a b c" corresponds to array ["a", "b", "c"]. Save the array of strings that corresponds to the text in this text box to a file.
        
        textView.text = ""
        
    }
    
    func saveTextView() {
        let docsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = docsDirectory.stringByAppendingPathComponent("array.plist")
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(path) {
            fileManager.createFileAtPath(path, contents: nil, attributes: nil)
        } else {
            if let bundle: NSString = NSBundle.mainBundle().pathForResource("array", ofType: "plist") {
                fileManager.copyItemAtPath(bundle as String, toPath: path, error: nil)
            }
        }
        let stringArray = split(textView.text) { $0 == " " } as NSArray
        stringArray.writeToFile(path, atomically: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.saveTextView()
    }

}
