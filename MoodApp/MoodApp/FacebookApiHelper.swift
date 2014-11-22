//
//  FacebookIntegrations.swift
//  MoodApp
//
//  Created by Valter Santos Matos on 22/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

//import Foundation
//
//class FacebookApiHelper {
//    
//
//    func getFriendsList() -> [Friend] {
//        
//        
//        var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
//        friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
//            var resultdict = result as NSDictionary
//            println("Result Dict: \(resultdict)")
//            var data : NSArray = resultdict.objectForKey("data") as NSArray
//            
//            for i in 0 ... data.count {
//                let valueDict : NSDictionary = data[i] as NSDictionary
//                let id = valueDict.objectForKey("id") as String
//                println("the id value is \(id)")
//            }
//            
//            var friends = resultdict.objectForKey("data") as NSArray
//            println("Found \(friends.count) friends")
//        }
//    }
//}