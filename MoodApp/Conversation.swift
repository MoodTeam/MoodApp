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
    var myId: Int64 = 0
    var friendId: Int64 = 0
    var myEmotion: Emotion = Emotion.Grey
    var hasBeenSeen: Bool = false
    
    init(){
    }
    
    init(lastUpdated: NSDate, myId: Int64, friendId: Int64, myEmotion: Emotion, hasBeenSeen: Bool) {
        self.lastUpdated = lastUpdated
        self.myId = myId
        self.friendId = friendId
        self.myEmotion = myEmotion
        self.hasBeenSeen = hasBeenSeen
    }
}