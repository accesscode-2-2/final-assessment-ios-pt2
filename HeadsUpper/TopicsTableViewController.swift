//
//  TopicsTableViewController.swift
//  HeadsUpper
//
//  Created by Lauren Caponong on 2/21/16.
//  Copyright © 2016 Lauren Caponong. All rights reserved.
//

import UIKit

class TopicsTableViewController: UITableViewController {
    
    var topicsAndValues = [String:[String]]()
    
    var selectedTopic: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        topicsAndValues = GameData().topicsAndValues

        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "Heads Up";
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicsAndValues.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = Array(topicsAndValues.keys)[indexPath.row]
        return cell
    }
    
    let gameSegueIdentifier = "showGameSegueIdentifier"
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == gameSegueIdentifier {
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            let theSelectedRow = Array(topicsAndValues.keys)[indexPath.row]
            let theDestination = segue.destinationViewController as! GameViewController
            
            theDestination.topicName = Array(topicsAndValues.keys)[indexPath.row]
            print("The topic name is: 1ST VIEW CONTROLLER: \(theDestination.topicName)")
            
//            if let destination = segue.destinationViewController as? GameViewController {
//                if let topicIndex = tableView.indexPathForSelectedRow?.row {
//                   destination.topicName = topics[topicIndex]
//                    print(destination.topicName)
//                                
//                }
            }
        }


//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        let row = indexPath.row
//        selectedTopic = String!(topics[row])
//        print("You selected: \(selectedTopic)")
//        
//        let secondViewController = self.storyboard?.instantiateInitialViewController() as! GameViewController
//        secondViewController.topicName = selectedTopic!
//        self.navigationController?.pushViewController(secondViewController, animated: true)
//        
//          }
    

}
