//
//  ConversationDetail.swift
//  MoodApp
//
//  Created by Charles Lin on 23/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import UIKit

class ConversationDetail {
    // conversationDetail is in format of (myId, (yourId, (Id, Conversation for this Id in this chat)))
    var conversationDetail = Dictionary<String, Dictionary<String, Dictionary<String, Conversation>>>()
    
    func add(conversation: Conversation) {
        var myId = conversation.myId
        var friendId = conversation.friendId
        
        // Adding this to my conversation
        if self.conversationDetail[myId] == nil {
            self.conversationDetail[myId] = Dictionary<String, Dictionary<String, Conversation>>()
        }
        if self.conversationDetail[myId]![friendId] == nil {
            self.conversationDetail[myId]![friendId] = Dictionary<String, Conversation>()
        }
        self.conversationDetail[myId]![friendId]![myId] = conversation
        
        // Adding this to friend's conversation
        if self.conversationDetail[friendId] == nil {
            self.conversationDetail[friendId] = Dictionary<String, Dictionary<String, Conversation>>()
        }
        if self.conversationDetail[friendId]![myId] == nil {
            self.conversationDetail[friendId]![myId] = Dictionary<String, Conversation>()
        }
        self.conversationDetail[friendId]![myId]![myId] = conversation
    }
    
    // As same conversation is duplicated for id1 and id2, order of id doesn't matter in fetch
    func fetch(id1: String, id2: String) -> Dictionary<String, Conversation>? {
        var conversationOfOnePerson = self.conversationDetail[id1]
        if conversationOfOnePerson == nil {
            return nil
        }
        return conversationOfOnePerson![id2]
    }
    
    func fetch(id: String) -> Dictionary<String, Dictionary<String, Conversation>>? {
        return self.conversationDetail[id]
    }
    
    func addConversation(myId: String, friendId: String, conversation: Conversation) {
        if self.conversationDetail[myId] == nil {
            self.conversationDetail[myId] = Dictionary<String, Dictionary<String, Conversation>>()
        }
        if self.conversationDetail[myId]![friendId] == nil {
            self.conversationDetail[myId]![friendId] = Dictionary<String, Conversation>()
        }
        self.conversationDetail[myId]![friendId]![myId] = conversation
        
    }
}