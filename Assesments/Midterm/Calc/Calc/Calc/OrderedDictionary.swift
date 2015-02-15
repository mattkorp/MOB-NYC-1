//
//  OrderedDictionary.swift
//  Lesson04
//
//  Created by Matthew Korporaal on 2/1/15.
//  Copyright (c) 2015 General Assembly. All rights reserved.
//

import Foundation

struct OrderedDictionary<Tk: Hashable, Tv> {
    var keys: [Tk] = []
    var values: [Tk:Tv] = [:]
    
    var count: Int {
        return self.keys.count;
    }
    
    // Explicitly define an empty initializer to prevent the default memberwise initializer from being generated
    init() {}
    
    // Initialize with a dictionary
    init(keys: [Tk], values: [Tv]) {
        self.init()
        var index = 0
        for (index, key) in enumerate(keys) {
            self.keys.append(key)
            self.values[key] = values[index]
        }
    }
    
    func keyForIndex(index: Int) -> Tk? {
        return self.keys[index]
    }
    
    subscript(index: Int) -> Tv? {
        get {
            let key = self.keys[index]
            return self.values[key]
        }
        set(newValue) {
            let key = self.keys[index]
            if (newValue != nil) {
                self.values[key] = newValue
            } else {
                self.values.removeValueForKey(key)
                self.keys.removeAtIndex(index)
            }
        }
    }
    
    subscript(key: Tk) -> Tv? {
        get {
            return self.values[key]
        }
        set(newValue) {
            if newValue == nil {
                self.values.removeValueForKey(key)
                self.keys.filter {$0 != key}
            } else {
                if let _ = self.values[key] {
                    self.values.updateValue(newValue!, forKey: key)
                } else {
                    self.values[key] = newValue!
                    self.keys.append(key)
                }
            }
        }
    }
    
    var description: String {
        var result = "{ "
        (0..<self.count).map {
            result += "[\($0)]: \(self.keys[$0]) => \(self[$0]!) "
        }
        result += "}"
        return result
    }
    
}