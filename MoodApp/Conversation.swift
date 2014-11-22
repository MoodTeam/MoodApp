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
    var LastUpdated = NSDate()
    var MyId: String = ""
    var FriendId: String = ""
    var MyEmotion: Emotion = Emotion.Grey
    var HasBeenSeen: Bool = false
}