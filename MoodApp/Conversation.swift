//
//  Conversation.swift
//  MoodApp
//
//  Created by Valter Santos Matos on 22/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import Foundation

class Conversation {
    //Automatic generated uniqueId
    var lastUpdated = NSDate()
    var myId: String = ""
    var friendId: String = ""
    var myEmotion: Emotion = Emotion.Grey
    var hasBeenSeen: Bool = false
    
    init(){
    }
    
    init(lastUpdated: NSDate, myId: String, friendId: String, myEmotion: Emotion, hasBeenSeen: Bool) {
        self.lastUpdated = lastUpdated
        self.myId = myId
        self.friendId = friendId
        self.myEmotion = myEmotion
        self.hasBeenSeen = hasBeenSeen
    }

    func toDictionary()->Dictionary<String, AnyObject>{
        var dictionary = Dictionary<String, AnyObject>()
        dictionary["myId"] = myId
        dictionary["friendId"] = friendId
        dictionary["myEmotion"] = myEmotion.rawValue
        return dictionary
    }
}