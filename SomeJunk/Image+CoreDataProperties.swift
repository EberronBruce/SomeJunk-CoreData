//
//  Image+CoreDataProperties.swift
//  SomeJunk
//
//  Created by Bruce Burgess on 12/15/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var item: Item?
    @NSManaged public var store: Store?

}
