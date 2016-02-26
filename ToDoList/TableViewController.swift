//
//  TableViewController.swift
//  ToDoList
//
//  Created by George He on 2/21/16.
//  Copyright © 2016 George He. All rights reserved.
//

/*NOTE: Data is persistent
*/
import UIKit
class TableViewController: UITableViewController {
    // Properties
    
    var toDoList = [ListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        //navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved lists
        if let savedList = loadList() {
            toDoList += savedList
        }
        filterList()
        savetoDoList()
    }
    
    func addDates(date: NSDate, daysToAdd:Int) -> NSDate{
        let secondsInDays: NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = date.dateByAddingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func filterList() {
        var index = 0
        while (index < toDoList.count){
            let task = toDoList[index]
            let completed = task.completed
            if completed {
                let date = task.date!
                let lastDate = addDates(date, daysToAdd: 1)
                //Compare Values
                if NSDate().compare(lastDate) == NSComparisonResult.OrderedDescending {
                    toDoList.removeAtIndex(index)
                    tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Fade)
                    index -= 1
                }
            }
            index += 1
        }
    }
    
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddViewController, task = sourceViewController.userTask {
            //Old code to edit values
            /*if let selectedIndexPath = tableView.indexPathForSelectedRow {
            // Update an existing task.
            toDoList[selectedIndexPath.row] = task
            tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {*/
            // Add a new task.
            let newIndexPath = NSIndexPath(forRow: toDoList.count, inSection: 0)
            toDoList.append(task)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            //}
            // Save the toDoList.
        }
        filterList()
        savetoDoList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .Checkmark
            {
                cell.accessoryType = .None
                toDoList[indexPath.row].date = nil
                toDoList[indexPath.row].completed = false
            }
            else
            {
                cell.accessoryType = .Checkmark
                toDoList[indexPath.row].date = NSDate()
                toDoList[indexPath.row].completed = true
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // View cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ListViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ListViewCell
        
        // Fetches the appropriate task
        let toDoItem = toDoList[indexPath.row]
        
        cell.textBox.text = toDoItem.name
        
        if toDoList[indexPath.row].completed {
            cell.accessoryType = .Checkmark
        }
        else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            toDoList.removeAtIndex(indexPath.row)
            savetoDoList()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let listDetailViewController = segue.destinationViewController as! AddViewController
            
            // Get the cell that generated this segue.
            if let selectedCell = sender as? ListViewCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let selectedTask = toDoList[indexPath.row]
                listDetailViewController.userTask = selectedTask
            }
        }
        else if segue.identifier == "Statistics" {
            let SViewController = segue.destinationViewController as! StatsViewController
            
            // Get the cell that generated this segue.
            SViewController.toDoList = toDoList
        }
        else if segue.identifier == "AddItem" {
            print("Adding new item.")
        }
        savetoDoList()
    }
    
    
    //Save stuff
    
    func savetoDoList() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(toDoList, toFile: ListItem.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save toDoList...")
        }
    }
    
    func loadList() -> [ListItem]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(ListItem.ArchiveURL.path!) as? [ListItem]
    }
}
