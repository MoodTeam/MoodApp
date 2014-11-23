//
//  FacebookIntegrations.swift
//  MoodApp
//
//  Created by Valter Santos Matos on 22/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

//import Foundation

class SaveUserFromFB {
    var userToSave: Friend = Friend()
    
    func saveMyProfile(fbUser: FBGraphUser){
        userToSave.name = fbUser.name
        userToSave.fId = fbUser.objectID
        
        println("Saving user: " + userToSave.name + " with the id: " + userToSave.fId)
        getMyPicture()
    }
    
    private func getMyPicture() -> Void {
        println("Getting the user " + userToSave.name + " picture url")
        
        var request : FBRequest = FBRequest.requestForMe()
        request.graphPath = "me/picture?redirect=false";
        request.HTTPMethod = "GET"
        request.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            var resultdict = result as NSDictionary
            var data = resultdict.objectForKey("data") as NSDictionary
            self.userToSave.imageUrl = data.objectForKey("url") as String
            
            println("Saving user: " + self.userToSave.name + " picture url: " + self.userToSave.imageUrl)
            GenericParse.addToParse("Friend", dict: self.userToSave.toDictionary())
            
        };
    }
}