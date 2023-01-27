//
//  File.swift
//  Notification Application
//
//  Created by Константин Малков on 29.12.2022.
//

import Foundation
import UIKit
import CoreData

class CategoryDataStack {
    static let instance = CategoryDataStack()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categoryVaultData = [Category]()
    
    func loadCategoryVaultData(){
        do {
            categoryVaultData = try context.fetch(Category.fetchRequest())
            print("load success key name")
        } catch {
            print("error loading key data")
        }
    }
    
    func saveData(name: String){
        let dataEntity = Category(context: context)
        
        dataEntity.name = name
        do {
            try context.save()
            loadCategoryVaultData()
            print("saved success key name")
        } catch {
            print("Error saving data")
        }
    }
    
    func deleteData(data: Category){
        context.delete(data)
        do {
            try context.save()
            loadCategoryVaultData()
        } catch {
            print("Error deleting key name")
        }
    }
}
