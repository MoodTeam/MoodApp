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
        if TestMode.currentMode == .Test {
            userToSave.name = MockDefault.defaultUser.name
            userToSave.fId = MockDefault.defaultUser.fId
        } else {
            userToSave.name = fbUser.name
            userToSave.fId = fbUser.objectID
        }
        
        println("Saving user: " + userToSave.name + " with the id: " + userToSave.fId)
        getMyPicture()
    }
    
    private func getMyPicture() {
        println("Getting the user \(userToSave.name) picture url")
        
        var request : FBRequest = FBRequest.requestForMe()
        request.graphPath = "me/picture?redirect=false";
        request.HTTPMethod = "GET"
        request.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> () in
            var result2: AnyObject! = result
            if TestMode.currentMode == .Test {
                result2 = ["data": ["url": MockDefault.defaultUser.imageUrl]]
            }
            
            if result2 != nil {
                var resultdict = result2 as NSDictionary
                var data = resultdict.objectForKey("data") as NSDictionary
                self.userToSave.imageUrl = data.objectForKey("url") as String
                
                NSLog("Saving user: \(self.userToSave.name) picture url: \(self.userToSave.imageUrl)")
                GenericParse.sharedInstance.addToParse("Friend", dict: self.userToSave.toDictionary())
            } else {
                NSLog("Error when fetching Facebook profile: \(error)")
            }
        }
    }
}