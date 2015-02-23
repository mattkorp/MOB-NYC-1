//
//  File.swift
//  Login
//
//  Created by Matthew Korporaal on 2/23/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import Foundation
import Parse

class ParseHelper {
    
    func addRelationalObjectsAndCache(relationKey: String, objects: [String: PFObject]) {
        // Save user categories to Parse
        // make a PFRelation object and add each category PFObject to it
        var relation = userSession.relationForKey(relationKey)
        for (_, object) in objects {
            relation.addObject(object)
            // not sure if this is right, so remove for now. not necessary
            // cache tag for later use
//            object.pin()
        }
    }
    
    func removeRelationalObjectsAndCache(relationKey: String) {
        userSession.removeObjectForKey(relationKey)
    }
    
}