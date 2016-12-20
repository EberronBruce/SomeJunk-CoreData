//
//  Item+CoreDataClass.swift
//  SomeJunk
//
//  Created by Bruce Burgess on 12/15/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }

}
