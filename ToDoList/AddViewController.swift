//
//  AddViewController.swift
//  ToDoList
//
//  Created by George He on 2/21/16.
//  Copyright © 2016 George He. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var userTask: ListItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let userTask = userTask
        {
            navigationItem.title = userTask.name
            textField.text   = userTask.name
        }
        textField.layer.borderColor = UIColor.lightGrayColor().CGColor
        textField.layer.borderWidth = 3.0
        textField.layer.cornerRadius = 10.0
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        navigationItem.title = textField.text
    }
    
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = textField.text ?? ""
            // Set the task to be passed along after the unwind segue.
            self.userTask = ListItem(name: name,  date:NSDate(), completed:false)
        }
        else {
            return
        }
    }


}

