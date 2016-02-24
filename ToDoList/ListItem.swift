//
//  ListItem.swift
//  ToDoList
//
//  Created by George He on 2/21/16.
//  Copyright © 2016 George He. All rights reserved.
//

import UIKit

class ListItem: NSObject, NSCoding {
    // Properties
    
    var name: String
    var date: NSDate?
    var completed: Bool
    
    // Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("list")
    
    // Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let dateKey = "date"
        static let completedKey = "completed"
    }
    
    // Initialization
    
    init?(name: String, date: NSDate?, completed: Bool) {
        // Initialize stored properties.
        self.name = name
        self.date = date
        self.completed = completed
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty {
            return nil
        }
    }
    
    // Encoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(completed, forKey: PropertyKey.completedKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as? NSDate
        let completed = aDecoder.decodeObjectForKey(PropertyKey.completedKey) as! Bool

        
        // Must call designated initializer.
        self.init(name: name, date:date,  completed:completed)
    }
    
}
