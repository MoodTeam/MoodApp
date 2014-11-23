//
//  SaveFriendsFromFB.swift
//  MoodApp
//
//  Created by Valter Santos Matos on 23/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

class SaveFriendsFromFB{
    var callbackAfterSaving: () -> Void
    var listOfFriendsToSave: [Friend] = [Friend]()

    init (callback: ()->Void){
        self.callbackAfterSaving = callback
    }
    
    func saveFriendsList() -> Void {

        var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
        friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            var resultdict = result as NSDictionary

            var data : NSArray = resultdict.objectForKey("data") as NSArray
            for i in 0 ... (data.count - 1) {
                let valueDict : NSDictionary = data[i] as NSDictionary

                var friend = Friend()
                friend.name = valueDict.objectForKey("name") as String
                friend.fId = valueDict.objectForKey("id") as String

                println("Saving user: " + friend.name + " with the id: " + friend.fId)
                self.listOfFriendsToSave.append(friend)
            }

            self.getFriendsPictures()
        }
    }
    
    private func getFriendsPictures()->Void {
        for i in 0 ... self.listOfFriendsToSave.count - 1 {
            var request : FBRequest = FBRequest.requestForMe()
            request.graphPath = self.listOfFriendsToSave[i].fId + "/picture?redirect=false";
            request.HTTPMethod = "GET"
            request.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
                var resultdict = result as NSDictionary
                var data = resultdict.objectForKey("data") as NSDictionary
                self.listOfFriendsToSave[i].imageUrl = data.objectForKey("url") as String
                
                println("Saving user: " + self.listOfFriendsToSave[i].name + " with the image url: " + self.listOfFriendsToSave[i].imageUrl)
                
                GenericParse.addToParse("Friend", dict: self.listOfFriendsToSave[i].toDictionary())
            }
        }
        self.callbackAfterSaving()
    }
}
