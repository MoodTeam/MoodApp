//
//  dsa.swift
//  MoodApp
//
//  Created by Valter Santos Matos on 23/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import UIKit

class AddFriendsTableViewController: UITableViewController {

    var friendData: Array<Friend> = []
    var errorData: Array<String> = ["Loading data..."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellLabel")
        GenericParse.sharedInstance.loadFromParse("Friend", parseFriendObjects, parseFriendError)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.errorData.count > 0) ? self.errorData.count : self.friendData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var dataToDisplay: String = (self.errorData.count > 0) ? "Error" : "Friend"
        
        
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        var cell = tableView.dequeueReusableCellWithIdentifier("CellLabel", forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        if self.errorData.count > 0 {
            cell.textLabel.text = self.errorData[indexPath.row]
            cell.backgroundColor = UIColor.whiteColor()
        } else {
            var friend = self.friendData[indexPath.row]
            cell.textLabel.text = friend.name
            cell.backgroundColor = Color.getFromName(Emotion.White)
            var image = TestMode.currentMode == .Test ? UIImage(named: friend.imageUrl) : UIImage(data: NSData(contentsOfURL: NSURL(string: friend.imageUrl)!)!)
            cell.imageView.image = image
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentUser = PFUser.currentUser()
        
        var clickedFriend = friendData[indexPath.row];
//
//        var newConversation = Conversation()
//        newConversation.myId = currentUser.password
//        newConversation.friendId = clickedFriend.fId
//        newConversation.myEmotion = Emotion.Grey
//        
//        GenericParse.addToParse("Conversation", dict: newConversation.toDictionary())
//        
//        
//        
//        var newConversation2 = Conversation()
//        newConversation2.myId = currentUser.password
//        newConversation2.friendId = clickedFriend.fId
//        newConversation2.myEmotion = Emotion.Grey
//        
//        GenericParse.addToParse("Conversation", dict: newConversation2.toDictionary())

        let secondViewController = ConversationViewController()
        self.presentViewController(secondViewController, animated: true, completion: nil)
    }
    
    
    
    func parseFriendObjects(objects: [AnyObject]!) {
        self.friendData = []
        self.errorData = []
        for object in objects {
            var dataRow = object as PFObject
            var fId = dataRow.objectForKey("fId") as String
            var name = dataRow.objectForKey("name") as String
            var imageUrl = dataRow.objectForKey("imageUrl") as String
            
            let currentUser = PFUser.currentUser()
            if (name == currentUser.email) {
                continue
            }
            
            self.friendData.append(Friend(fId: fId, name: name, imageUrl: imageUrl))
        }
        self.tableView.reloadData()
    }
    
    func parseFriendError(error: NSError!) {
        NSLog("Error detail: \(error)")
        self.friendData = []
        self.errorData = ["Data cannot be loaded"]
        self.tableView.reloadData()
    }
}
