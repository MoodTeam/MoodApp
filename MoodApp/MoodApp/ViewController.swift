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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.	
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends", "read_friendlists"]
    }

     func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
         println("User Logged In")
         println("This is where you perform a segue.")
     }

    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser){
        println("User Name: \(user.name)")
        
        //receive an array of friends
        //save friends in parser
        
        
        
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

