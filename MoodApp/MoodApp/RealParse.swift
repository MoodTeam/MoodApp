//
//  RealParse.swift
//  MoodApp
//
//  Created by Charles Lin on 29/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import Foundation

class RealParse : IParse {
    
    required init() {
    }
    
    // Sample usage: 
    // GenericParse.addToParse("NameInParse", dict: ["fId": "3", "name": "Hello World", "imageUrl": ""])
    func addToParse(parseClassName: String, dict: Dictionary<String, AnyObject>) {
        
        var query = PFQuery(className: parseClassName)
        query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]!, error: NSError!) -> Void in
            
            for object in objects {
                if (parseClassName == "Friend")
                {
                    var dataRow = object as PFObject
                    var fId = dataRow.objectForKey("fId") as String
                    var fIdToSave = dict["fId"] as String
                    if  (fId == fIdToSave)
                    {
                        return
                    }
                }
            }
            
            
            var dataRow = PFObject(className: parseClassName)
            for keyValue in dict {
                dataRow.setObject(keyValue.1, forKey: keyValue.0)
            }
            dataRow.saveInBackgroundWithBlock {
                (success: Bool!, error: NSError!) -> () in
                if (success != nil && success!) {
                    NSLog("Object created in \(parseClassName) with id: \(dataRow.objectId)")
                } else {
                    NSLog("%@", error)
                }
            }
        }
    }
    
    // Sample usage:
    // func parseObjects(objects: [AnyObject]!) { ... }
    // func handleError(error: NSError!) { ... }
    // GenericParse.loadFromParse("NameInParse", parseObjects, handleError)
    func loadFromParse(parseClassName: String, onLoadSuccess: ([AnyObject]!) -> (), onLoadFailure: (NSError!) -> ()) {
        var query = PFQuery(className: parseClassName)
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]!, error: NSError!) -> () in
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
