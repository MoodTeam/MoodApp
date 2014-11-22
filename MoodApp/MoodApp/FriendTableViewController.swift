//
//  FriendTableViewController.swift
//  MoodApp
//
//  Created by Charles Lin on 22/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController {

    var friendData: Array<Friend> = []
    var errorData: Array<String> = ["Loading data..."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        GenericParse.loadFromParse("Friend", parseFriendObjects, parseFriendError)
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
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        if self.errorData.count > 0 {
            cell.textLabel.text = self.errorData[indexPath.row]
            cell.backgroundColor = UIColor.whiteColor()
        } else {
            cell.textLabel.text = self.friendData[indexPath.row].name
            cell.backgroundColor = Color.getFromName(Emotion.Grey)
        }
        return cell
    }
    
    func parseFriendObjects(objects: [AnyObject]!) {
        self.friendData = []
        self.errorData = []
        for object in objects {
            var dataRow = object as PFObject
            var fId = dataRow.objectForKey("fId") as String
            var name = dataRow.objectForKey("name") as String
            var imageUrl = dataRow.objectForKey("imageUrl") as String
            
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
