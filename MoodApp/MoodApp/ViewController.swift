//
//  ViewController.swift
//  MoodApp
//
//  Created by Ashton Coghlan on 11/22/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBLoginViewDelegate {
    
    @IBOutlet weak var fbLoginView: FBLoginView!
    var hasloginViewShowingLoggedInUserBeenCalled : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.	
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends", "read_friendlists"]
    }

     func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
         println("User Logged In")
         println("This is where you perform a segue.")
        hasloginViewShowingLoggedInUserBeenCalled = true
     }

    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser){
        
        if(hasloginViewShowingLoggedInUserBeenCalled == false) // delegate is fired twice
        {
            return;
        }
        
        //Call the loading view
        
        var saveUserInformation = SaveUserInformation()
        saveUserInformation.saveMyProfile(user)
        
        //get friends list
        
        
        //move to the othger view
        
        
//            
//            hasloginViewShowingLoggedInUserBeenCalled = true;
//            
//            println("User Name: \(user.name)")
//            
//            
//            //Call the loading view
//            
//            
//            
//            var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
//            friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
//                var resultdict = result as NSDictionary
//                println("Result Dict: \(resultdict)")
//                
//                var friends: [Friend] = [Friend]()
//                var data : NSArray = resultdict.objectForKey("data") as NSArray
//                for i in 0 ... data.count {
//                    let valueDict : NSDictionary = data[i] as NSDictionary
//                    
//                    var friend = Friend()
//                    friend.name = valueDict.objectForKey("name") as String
//                    friend.fId = valueDict.objectForKey("id") as String
//                    
//                    friends.append(friend)
//                }
//                
//                //Friends have the list of friends
//                //Call the TableFriendsViewList !!!
//                
//            }
//            
//           
//            var request : FBRequest = FBRequest.requestForMe()
//            request.graphPath = "me/picture?redirect=false";
//            request.HTTPMethod = "GET"
//            request.startWithCompletionHandler(fbAlbumRequestHandler);
        
    }
    
    func fbAlbumRequestHandler(connection:FBRequestConnection!, result:AnyObject!, error:NSError!){
        var resultdict = result as NSDictionary
        var data = resultdict.objectForKey("data") as NSDictionary
        var imageUrl = data.objectForKey("url") as String
    }
    
 

     func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
     println("User Logged Out")
     }

     func loginView(loginView : FBLoginView!, handleError:NSError) {
     println("Error: \(handleError.localizedDescription)")
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}








