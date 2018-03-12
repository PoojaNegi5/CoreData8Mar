//
//  DataEntity+CoreDataProperties.swift
//  CoreData8Mar
//
//  Created by Appinventiv on 08/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//
//

import Foundation
import CoreData


extension DataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataEntity> {
        return NSFetchRequest<DataEntity>(entityName: "DataEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var email: String?

}
