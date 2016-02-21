//
//  TopicTableViewController.swift
//  HeadsUpper
//
//  Created by Jovanny Espinal on 2/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import UIKit

class TopicTableViewController: UITableViewController {
    
    var topicsAndAnswers = [String:[String]]()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        topicsAndAnswers = GameData().topicsAndAnswers
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return topicsAndAnswers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath)
        cell.textLabel!.text = Array(topicsAndAnswers.keys)[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let answersViewController = segue.destinationViewController as! AnswerViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let topic = Array(topicsAndAnswers.keys)[indexPath.row]
            
            if var answers = topicsAndAnswers[topic] {
                answers.shuffleInPlace()
                
                answersViewController.answers = answers
            }
        }
    }
}