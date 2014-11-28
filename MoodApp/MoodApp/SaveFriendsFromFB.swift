//
//  SaveFriendsFromFB.swift
//  MoodApp
//
//  Created by Valter Santos Matos on 23/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

class SaveFriendsFromFB {
    var callbackAfterSaving: () -> ()
    var listOfFriendsToSave: [Friend] = [Friend]()

    init (callback: () -> ()) {
        self.callbackAfterSaving = callback
    }
    
    func saveFriendsList() -> () {
        var friendsRequest: FBRequest = FBRequest.requestForMyFriends()
        friendsRequest.startWithCompletionHandler{ (connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> () in
            var result2: AnyObject! = result
            if TestMode.currentMode == .Test {
                var mockResult = [String: [[String: String]]]()
                for friend in MockDefault.friends {
                    if mockResult["data"] == nil {
                        mockResult["data"] = [[String: String]]()
                    }
                    mockResult["data"]!.append(["name": friend.name, "id": friend.fId])
                }
                result2 = mockResult
            }
            
            var resultdict = result2 as NSDictionary
            var data = resultdict.objectForKey("data") as NSArray
            for object in data {
                let valueDict : NSDictionary = object as NSDictionary

                var friend = Friend()
                friend.name = valueDict.objectForKey("name") as String
                friend.fId = valueDict.objectForKey("id") as String

                println("Saving user: " + friend.name + " with the id: " + friend.fId)
                self.listOfFriendsToSave.append(friend)
            }

            self.getFriendsPictures()
        }
    }
    
    private func getFriendsPictures() -> () {
        for friend in self.listOfFriendsToSave {
            var request : FBRequest = FBRequest.requestForMe()
            request.graphPath = friend.fId + "/picture?redirect=false";
            request.HTTPMethod = "GET"
            request.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> () in
                var result2: AnyObject! = result
                if TestMode.currentMode == .Test {
                    result2 = ["data": ["url": MockDefault.defaultUser.imageUrl]]
                    for tempFriend in MockDefault.friends {
                        if friend.fId == tempFriend.fId {
                            friend.imageUrl = tempFriend.imageUrl
                            break
                        }
                    }
                }
                
                var resultdict = result2 as NSDictionary
                var data = resultdict.objectForKey("data") as NSDictionary
                friend.imageUrl = data.objectForKey("url") as String
                
                println("Saving user: " + friend.name + " with the image url: " + friend.imageUrl)
                
                GenericParse.sharedInstance.addToParse("Friend", dict: friend.toDictionary())
            }
        }
        self.callbackAfterSaving()
    }
}
