//
//  CoreDataManager.swift
//  CoreData8Mar
//
//  Created by Appinventiv on 08/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager{
    
    var entity : String?
    
    init(entityName: String?) {
       self.entity = entityName
    }
    
    func delete(user : DataEntity)
    {
       let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity!)
        request.returnsObjectsAsFaults = false
        managedContext.delete(user)
        do{
            try managedContext.save()
        }
        catch{
            print("error")
        }
       
    }

    
    func fetch() -> [NSManagedObject]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity!)
        request.returnsObjectsAsFaults = false
        do{
            return try (managedContext.fetch(request) as? [NSManagedObject])
            
        }catch{
            print("Found exception")
            return nil
        }
    }
    
    func save(name :String?,age : String?,email : String?)
    {
        let entity = NSEntityDescription.entity(forEntityName: self.entity!, in: managedContext)
        let user = NSManagedObject.init(entity:entity!, insertInto: managedContext) as! DataEntity
        user.name = name ?? ""
        user.age = (Int16(age!)!)
        user.email = email ?? ""
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func update(name :String?,age : String?,email : String?,user : DataEntity)
    {
        user.name = name ?? ""
        user.age = (Int16(age!)!)
        user.email = email ?? ""
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
}
