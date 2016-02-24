//
//  StatsViewController.swift
//  ToDoList
//
//  Created by George He on 2/21/16.
//  Copyright © 2016 George He. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var number: UILabel!
    var toDoList = [ListItem]?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var completedCount = 0
        var listCount = 0
        for item in toDoList! {
            if item.completed {
                completedCount += 1
            }
            listCount += 1
        }
        total.text = String(listCount)
        number.text = String(completedCount)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

