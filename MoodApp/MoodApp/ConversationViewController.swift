//
//  ConversationViewController.swift
//  MoodApp
//
//  Created by Charles Lin on 22/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var addFriendButton: UIButton!
    
    var userId = ""
    var friendDict = Dictionary<String, Friend>()
    var errorData: Array<String> = ["Loading data..."]
    var conversationDetail = ConversationDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.userId = TestMode.currentMode ==  .Test ? MockDefault.defaultUser.fId : PFUser.currentUser().password
        // This line tells tableView to create its own ConversationTableViewCell instead of fetching from storyboard
        //self.tableView.registerClass(ConversationTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.loadFriend()
        self.loadConversation()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.errorData.count > 0 {
            return self.errorData.count
        }
        var myConversations = self.conversationDetail.fetch(userId)
        if myConversations == nil {
            return 0
        }
        return myConversations!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var dataToDisplay: String = (self.errorData.count > 0) ? "Error" : "Table"
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as ConversationTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.None
        
        if dataToDisplay == "Error" {
            cell.friendName.text = self.errorData[indexPath.row]
            cell.friendLastUpdate.text = ""
            cell.backgroundColor = UIColor.whiteColor()
            cell.myEmotion.backgroundColor = cell.backgroundColor
            cell.borderLine.backgroundColor = cell.backgroundColor
        } else {
            var myConversations = self.conversationDetail.fetch(userId)
            if myConversations != nil {
                var targetIndex = indexPath.row
                var counter = 0
                for keyValuePair in myConversations! {
                    if counter == targetIndex {
                        var friend = self.friendDict[keyValuePair.0]
                        cell.friendName.text = (friend == nil) ? "John Doe" : friend!.name
                        
                        cell.friendLastUpdate.text = "Last Updated at 0 minute ago"
                        
                        var conversationDict = keyValuePair.1
                        cell.backgroundColor = Color.getFromName(conversationDict[keyValuePair.0]!.myEmotion)
                        
                        var image = TestMode.currentMode == .Test ? UIImage(named: friend!.imageUrl) : UIImage(data: NSData(contentsOfURL: NSURL(string: friend!.imageUrl)!)!)
                        cell.friendImage.image = image
                        cell.myEmotion.backgroundColor = Color.getFromName(conversationDict[userId]!.myEmotion)
                        cell.borderLine.backgroundColor = UIColor.blackColor()
                        break;
                    }
                    counter++
                }
            }
            
        }
        return cell
    }
    
    func parseFriendObjects(objects: [AnyObject]!) {
        for object in objects {
            var dataRow = object as PFObject
            var fId = dataRow.objectForKey("fId") as String
            var name = dataRow.objectForKey("name") as String
            var imageUrl = dataRow.objectForKey("imageUrl") as String
            
            friendDict.updateValue(Friend(fId: fId, name: name, imageUrl: imageUrl), forKey: fId)
        }
        self.tableView.reloadData()
    }
    
    func parseFriendError(error: NSError!) {
        NSLog("Error detail: \(error)")
        var timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("loadFriend"), userInfo: nil, repeats: false)
    }
    
    func parseConversationObjects(objects: [AnyObject]!) {
        self.errorData = []
        for object in objects {
            var dataRow = object as PFObject
            var myId = dataRow.objectForKey("myId") as String
            var friendId = dataRow.objectForKey("friendId") as String
            var myEmotion = dataRow.objectForKey("emotion") as Int
            var isSeen = dataRow.objectForKey("isSeen") as Bool
            
            var conversation = Conversation(lastUpdated: NSDate(), myId: myId, friendId: friendId, myEmotion: Emotion(rawValue: myEmotion)!, isSeen: isSeen)
            conversationDetail.add(conversation)
        }
        self.tableView.reloadData()
    }
    
    func parseConversationError(error: NSError!) {
        NSLog("Error detail: \(error)")
        self.errorData = ["Data cannot be loaded"]
        self.tableView.reloadData()
    }
    
    func loadFriend() {
        GenericParse.sharedInstance.loadFromParse("Friend", parseFriendObjects, parseFriendError)
    }
    
    func loadConversation() {
        if (self.friendDict.count == 0) {
            NSLog("Loading from Friend isn't done yet")
            var timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("loadConversation"), userInfo: nil, repeats: false)
        } else {
            GenericParse.sharedInstance.loadFromParse("Conversation", parseConversationObjects, parseConversationError)
        }
    }
    
    func addSampleConversation(myId: String, yourId: String, myEmotion: Emotion, yourEmotion: Emotion) {
        var conversation = Conversation(lastUpdated: NSDate(), myId: myId, friendId: yourId, myEmotion: myEmotion, isSeen: true)
        GenericParse.sharedInstance.addToParse("Conversation", dict: conversation.toDictionary())
        
        conversation = Conversation(lastUpdated: NSDate(), myId: yourId, friendId: myId, myEmotion: yourEmotion, isSeen: true)
        GenericParse.sharedInstance.addToParse("Conversation", dict: conversation.toDictionary())
    }
    
    @IBAction func onButtonDown(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("AddFriendsVCID") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
}
