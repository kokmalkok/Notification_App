//
//  GroupListStack.swift
//  Notification Application
//
//  Created by Константин Малков on 24.12.2022.
//

import Foundation
import UIKit
import CoreData


class GroupListStack {
    
    static let instance = GroupListStack()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var groupVaultData = [GroupListEntity]()
    
    
    func loadDataGroupEntity(){
        do {
            groupVaultData = try context.fetch(GroupListEntity.fetchRequest())
        } catch {
            print("error loading data for Group list")
        }
    }
    
    func saveDataGroup(data: CellData) {
        let group = GroupListEntity(context: context)
        let colorData = data.Color.encode()
        
        group.color = colorData
        group.image = data.Image.pngData()
        group.title = data.Title
        group.count = Double(data.Count)
        
        
        do {
            try context.save()
            loadDataGroupEntity()
        } catch {
            print(error)
        }
    }
    
    func deleteDataGroup(data: GroupListEntity) {
        context.delete(data)
        do {
            try context.save()
            loadDataGroupEntity()
        } catch {
            print(error)
        }
    }
    
    func updateItemInGroup(edit entity: GroupListEntity, data: CellData){
        
    }
}

extension UIColor {
    class func color(withData data: Data) -> UIColor? {
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
    }
    func encode() -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: self,requiringSecureCoding: false)
    }
}
