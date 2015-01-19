//
//  Dog.swift
//  Lesson03
//
//  Created by Matthew Korporaal on 1/19/15.
//  Copyright (c) 2015 General Assembly. All rights reserved.
//

import Foundation

class Dog: Animal {
    
    override func prettyAnimalName() -> String {
        return "DOG name: " + self.name
        
    }
}