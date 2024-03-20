//
//  Record+CoreDataProperties.swift
//  
//
//  Created by Abdurazzoqov Islombek on 07/06/23.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var nameGamer: String?
    @NSManaged public var steps: Int32

}
