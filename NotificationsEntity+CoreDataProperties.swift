//
//  NotificationsEntity+CoreDataProperties.swift
//  
//
//  Created by Константин Малков on 11.01.2023.
//
//

import Foundation
import CoreData


extension NotificationsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotificationsEntity> {
        return NSFetchRequest<NotificationsEntity>(entityName: "NotificationsEntity")
    }

    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var groupListEntity: GroupListEntity?

}
