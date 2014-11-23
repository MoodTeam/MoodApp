//
//  GenericParse.swift
//  MoodApp
//
//  Created by Charles Lin on 22/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import Foundation

struct GenericParse {
    
    // Sample usage: 
    // GenericParse.addToParse("NameInParse", dict: ["fId": "3", "name": "Hello World", "imageUrl": ""])
    static func addToParse(parseClassName: String, dict: Dictionary<String, AnyObject>) {
        
        //load from parse
        //if exists
        //return
        
        var dataRow = PFObject(className: parseClassName)
        for keyValue in dict {
            dataRow.setObject(keyValue.1, forKey: keyValue.0)
        }
        dataRow.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            if (success != nil && success!) {
                NSLog("Object created in \(parseClassName) with id: \(dataRow.objectId)")
            } else {
                NSLog("%@", error)
            }
        }
    }
    
    // Sample usage:
    // func parseObjects(objects: [AnyObject]!) { ... }
    // func handleError(error: NSError!) { ... }
    // GenericParse.loadFromParse("NameInParse", parseObjects, handleError)
    static func loadFromParse(parseClassName: String, onLoadSuccess: ([AnyObject]!) -> (), onLoadFailure: (NSError!) -> ()) {
        var query = PFQuery(className: parseClassName)
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                NSLog("Successfully retrieved \(objects.count) objects from \(parseClassName).")
                onLoadSuccess(objects)
            } else {
                NSLog("Error loading \(parseClassName) from Parse")
                onLoadFailure(error)
            }
        }
    }

}
