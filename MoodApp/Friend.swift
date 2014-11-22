//
//  Friend.swift
//  MoodApp
//
//  Created by Valter Santos Matos on 22/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import Foundation

class Friend {
    var fId: String = "" //facebookId => UniqueId
    var name: String = ""
    var imageUrl: String = ""
    
    init(){
    }
    
    init(fId: String, name: String, imageUrl: String) {
        self.fId = fId
        self.name = name
        self.imageUrl = imageUrl
    }
}