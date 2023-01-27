//
//  NotificationsDataStack.swift
//  Notification Application
//
//  Created by Константин Малков on 28.12.2022.
//

import Foundation
import CoreData
import UIKit
//сделать сохранение словаря
//настроить переменную для сохранения данных
class NotificationsDataStack {
    
    static let instance = NotificationsDataStack()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notificationVaultData = [NotificationsEntity]()
    
    func loadNotificationDataEntity(){
        do {
            notificationVaultData = try context.fetch(NotificationsEntity.fetchRequest())
        } catch {
            print("error loading data for Notification list")
        }
    }
    
    func saveNotificationDataEntity(data: NotificationData) {
        let dataEntity = NotificationsEntity(context: context)
        dataEntity.title = data.Title
        dataEntity.subtitle = data.Subtitle
        
        print("\(data.Title)+\(data.Subtitle)")
//        for i in data {
//            dataEntity.title = i.Title
//            dataEntity.subtitle = i.Subtitle
//            dataEntity.index = Double(i.Index ?? 999)
//            print("\(i.Title)+\(i.Subtitle)")
//        }
        
        do {
            try context.save()
            
            loadNotificationDataEntity()
        } catch {
            print("Error saving data in Notification Entity")
        }
        
    }
    
    func deleteAllData(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "NotificationsEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            loadNotificationDataEntity()
        } catch {
            print("Error deleting all data from entity")
        }
    }
    
    func deleteNotificationData(data: NotificationsEntity) {
        context.delete(data)
        do {
            try context.save()
            loadNotificationDataEntity()
        } catch {
            print("Error deleting")
        }
    }
    
}
