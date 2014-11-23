//
//  FacebookIntegrations.swift
//  MoodApp
//
//  Created by Valter Santos Matos on 22/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

//import Foundation

class SaveUserInformation {
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
        request.startWithCompletionHandler(fbAlbumRequestHandler);
    }

    private func fbAlbumRequestHandler(connection:FBRequestConnection!, result:AnyObject!, error:NSError!){
        var resultdict = result as NSDictionary
        var data = resultdict.objectForKey("data") as NSDictionary
        userToSave.imageUrl = data.objectForKey("url") as String
        
        
        println("Saving user: " + userToSave.name + " picture url: " + userToSave.imageUrl)
        GenericParse.addToParse("Friend", dict: userToSave.toDictionary())
    }
}