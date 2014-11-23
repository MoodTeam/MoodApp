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
        
        var saveUserFromFB = SaveUserFromFB()
        saveUserFromFB.saveMyProfile(user)
        
        var saveFriendsFromFB = SaveFriendsFromFB()
        saveFriendsFromFB.saveFriendsList()
        
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








