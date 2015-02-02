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
    
    private var dataIn: [String]?
    
    init() {}
    
    func readData() -> [String]? {
        var docsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        var path = docsDirectory.stringByAppendingPathComponent("array.plist")
        dataIn = NSArray(contentsOfFile: path) as? [String]
        return dataIn
    }
    
    func writeData(data:[String]) -> Bool? {
        var docsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        var path = docsDirectory.stringByAppendingPathComponent("array.plist")
        var fileManager = NSFileManager.defaultManager()
        if (!fileManager.fileExistsAtPath(path)) {
            var bundle: NSString = NSBundle.mainBundle().pathForResource("array", ofType: "plist")!
            fileManager.copyItemAtPath(bundle, toPath: path, error: nil)
        }
        var data = NSArray(array: data as NSArray)
        return data.writeToFile(path, atomically: true) ? true : false

    }
}