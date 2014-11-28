//
//  MockDefault.swift
//  MoodApp
//
//  Created by Charles Lin on 29/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import Foundation

struct MockDefault {
    static var defaultUser = Friend(fId: "1", name: "Tester1", imageUrl: "TestPic1.gif")
    
    static var friends = [Friend(fId: "2", name: "Tester2", imageUrl: "TestPic2.png"),
                          Friend(fId: "3", name: "Tester3", imageUrl: "TestPic3.png"),
                          Friend(fId: "4", name: "Tester4", imageUrl: "TestPic4.png")]
    
    static var conversations = [
        Conversation(lastUpdated: NSDate(), myId: "1", friendId: "2", myEmotion: Emotion.Green, isSeen: true),
        Conversation(lastUpdated: NSDate(), myId: "2", friendId: "1", myEmotion: Emotion.Green, isSeen: true),
        Conversation(lastUpdated: NSDate(), myId: "1", friendId: "3", myEmotion: Emotion.Red, isSeen: true),
        Conversation(lastUpdated: NSDate(), myId: "3", friendId: "1", myEmotion: Emotion.Red, isSeen: true)]
}