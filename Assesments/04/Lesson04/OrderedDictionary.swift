//
//  OrderedDictionary.swift
//  Lesson04
//
//  Created by Matthew Korporaal on 2/1/15.
//  Copyright (c) 2015 General Assembly. All rights reserved.
//

import Foundation

struct OrderedDictionary<Tk: Hashable, Tv> {
    var keys: Array<Tk> = []
    var values: Dictionary<Tk,Tv> = [:]
    
    var count: Int {
        assert(keys.count == values.count, "Keys and values array out of sync")
        return self.keys.count;
    }
    
    // Explicitly define an empty initializer to prevent the default memberwise initializer from being generated
    init() {}
    
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
        var result = "{\n"
        (0..<self.count).map {
            result += "[\($0)]: \(self.keys[$0]) => \(self[$0]!)\n"
        }
        result += "}"
        return result
    }
    
}