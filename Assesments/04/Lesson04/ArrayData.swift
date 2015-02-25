//
//  ArrayData.swift
//  Lesson04
//
//  Created by Matthew Korporaal on 2/2/15.
//  Copyright (c) 2015 General Assembly. All rights reserved.
//

import Foundation
import UIKit

class ArrayData {
    
    func readData() -> [String]? {
        let docsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = docsDirectory.stringByAppendingPathComponent("array.plist")
        return NSArray(contentsOfFile: path) as? [String]
        
    }
    
    func writeData(data:[String]) -> Bool? {
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
        let data = NSArray(array: data as NSArray as [AnyObject])
        return data.writeToFile(path, atomically: true) ? true : false

    }
    
}