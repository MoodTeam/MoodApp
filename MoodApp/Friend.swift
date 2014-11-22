//
//  Friend.swift
//  MoodApp
//
//  Created by Valter Santos Matos on 22/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import Foundation

class Friend{
    var UserId: String = "" //facebookId => UniqueId
    var FirstName: String = ""
    var LastName: String = ""
    var ImageUrl: String = ""
    
    init(UserId: String, FirstName: String, LastName: String, ImageUrl: String) {
        self.UserId = UserId
        self.FirstName = FirstName
        self.LastName = LastName
        self.ImageUrl = ImageUrl
    }
}