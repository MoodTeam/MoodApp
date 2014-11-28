//
//  MockParse.swift
//  MoodApp
//
//  Created by Charles Lin on 29/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import Foundation

class MockParse : IParse {
    var record = [String: [PFObject]]()
    
    required init() {
        for friend in MockDefault.friends {
            self.addToParse("Friend", dict: friend.toDictionary())
        }
        
        for conversation in MockDefault.conversations {
            self.addToParse("Conversation", dict: conversation.toDictionary())
        }
    }
    
    func addToParse(parseClassName: String, dict: Dictionary<String, AnyObject>) {
        var pfObject = PFObject(className: parseClassName)
        for keyValue in dict {
            pfObject.setObject(keyValue.1, forKey: keyValue.0)
        }
        
        if self.record[parseClassName] == nil {
            self.record[parseClassName] = [PFObject]()
            NSLog("Object created in \(parseClassName) with id: 0")
        }
        self.record[parseClassName]!.append(pfObject)
    }
    
    func loadFromParse(parseClassName: String, onLoadSuccess: ([AnyObject]!) -> (), onLoadFailure: (NSError!) -> ()) {
        if self.record[parseClassName] == nil {
            NSLog("Error loading \(parseClassName) from MockParse")
            onLoadFailure(NSError(domain: "NoRecord", code: 204, userInfo: [NSLocalizedDescriptionKey : "\(parseClassName) table is not defined"]))
        } else {
            NSLog("Successfully retrieved \(self.record[parseClassName]!.count) objects from \(parseClassName).")
            onLoadSuccess(self.record[parseClassName]!)
        }
    }
}