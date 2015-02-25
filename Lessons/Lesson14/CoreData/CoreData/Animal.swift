//
//  Animal.swift
//  CoreData
//
//  Created by Rudd Taylor on 2/23/15.
//  Copyright (c) 2015 ga. All rights reserved.
//

import Foundation
import CoreData

@objc(Animal)

class Animal: NSManagedObject {
    @NSManaged var name: String
}

