//
//  GroupListEntity+CoreDataProperties.swift
//  
//
//  Created by Константин Малков on 09.01.2023.
//
//

import Foundation
import CoreData


extension GroupListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupListEntity> {
        return NSFetchRequest<GroupListEntity>(entityName: "GroupListEntity")
    }

    @NSManaged public var color: Data?
    @NSManaged public var count: Double
    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var notificationsEntity: NotificationsEntity?

}
