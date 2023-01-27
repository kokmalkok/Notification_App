//
//  GroupList+CoreDataProperties.swift
//  
//
//  Created by Константин Малков on 24.12.2022.
//
//

import Foundation
import CoreData


extension GroupListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupListEntity> {
        return NSFetchRequest<GroupListEntity>(entityName: "GroupListEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var count: Double
    @NSManaged public var image: Data?
    @NSManaged public var color: Data?

}
