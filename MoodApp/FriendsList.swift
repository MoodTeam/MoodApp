//
//  FriendsList.swift
//  MoodApp
//
//  Created by Valter Santos Matos on 22/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import Foundation

class FriendsList {
    var myId: String = "";
    var friendId: String = "";
    
    init(){
    }
    
    init(myId: String, friendId: String) {
        self.myId = myId
        self.friendId = friendId
    }
}