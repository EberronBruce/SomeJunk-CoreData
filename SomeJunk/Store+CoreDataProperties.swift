//
//  Store+CoreDataProperties.swift
//  SomeJunk
//
//  Created by Bruce Burgess on 12/15/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import Foundation
import CoreData


extension Store {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store");
    }

    @NSManaged public var name: String?
    @NSManaged public var image: Image?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension Store {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
