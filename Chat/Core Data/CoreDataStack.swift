//
//  CoreDataStack.swift
//  Chat
//
//  Created by Dmitry Bakulin on 05/11/2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    init() {
        
    }
    
    private var storeURL : URL {
        get {
            let documentsDirURL : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let url = documentsDirURL.appendingPathComponent("Store.sqlite")
            
            return url
        }
    }
    
    private let managedObjectModelName = "Chat"
    private var _managedObjectModel : NSManagedObjectModel?
    private var managedObjectModel : NSManagedObjectModel? {
        get {
            if _managedObjectModel == nil {
                guard let modelURL = Bundle.main.url(forResource: managedObjectModelName, withExtension: "momd") else {
                    print("Empty model url!")
                    return nil
                }
                
                _managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
            }
            return _managedObjectModel
        }
    }
    
    private var _persistentStoreCoordinator: NSPersistentStoreCoordinator?
    private var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        get {
            if _persistentStoreCoordinator == nil {
                guard let model = self.managedObjectModel else {
                    print("no mo model")
                    return nil
                }
                
                _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
                
                do {
                    try _persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType,
                                                                        configurationName: nil,
                                                                        at: storeURL,
                                                                        options: nil)
                } catch {
                    assert(false, "Error adding persistent store coordinator: \(error)")
                }
            }
            
            return _persistentStoreCoordinator
        }
    }
    
    private var _masterContext: NSManagedObjectContext?
    private var masterContext: NSManagedObjectContext? {
        get {
            if _masterContext == nil {
                let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
                guard let persistentStoreCoordinator = self.persistentStoreCoordinator else {
                    print("Empty persistent store coordinator!")
                    
                    return nil
                }
                
                context.persistentStoreCoordinator = persistentStoreCoordinator
                context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                context.undoManager = nil
                _masterContext = context
            }
            
            return _masterContext
        }
    }
    
    private var _mainContext: NSManagedObjectContext?
    public var mainContext: NSManagedObjectContext? {
        get {
            if _mainContext == nil {
                let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
                guard let parentContext = self.masterContext else {
                    print("no master context")
                    
                    return nil
                }
                
                context.parent = parentContext
                context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                context.undoManager = nil
                _mainContext = context
            }
            
            return _mainContext
        }
    }
    
    private var _saveContext: NSManagedObjectContext?
    public var saveContext: NSManagedObjectContext! {
        get {
            if _saveContext == nil {
                let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
                guard let parentContext = self.mainContext else {
                    print("no main context")
                    
                    return nil
                }
                
                context.parent = parentContext
                context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                context.undoManager = nil
                _saveContext = context
            }
            
            return _saveContext
        }
    }
    
    
    

    public func performSave(context: NSManagedObjectContext, completionHandler: (() -> Void)? ) {
        if context.hasChanges {
            context.perform { [weak self] in
                do {
                    try context.save()
                    print("saving is sucesful")
                } catch {
                    print("context save error: \(error.localizedDescription)")
                }
                    
                if let parent = context.parent {
                    self?.performSave(context: parent, completionHandler: completionHandler)
                } else {
                    completionHandler?()
                }
            }
        } else {
            completionHandler?()
        }
    }
    
    
    //    public func performSave(context: NSManagedObjectContext, completionHandler : ) {
    //    init() {
    //
    //    }
    
//    func readUser() -> User {
//
//    }
//    func saveUserData() -> Bool {
//        
//    }
//    func deleteAllRecords() {
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let context = delegate.persistentContainer.viewContext
//
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "AppUser")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//
//        do {
//            try saveContext.execute(deleteRequest)
//            try saveContext.save()
//        } catch {
//            print ("There was an error")
//        }
//    }
    
    func readUserData() -> AppUser? {
//    func readUserData() {
//        let userData = User()
//        deleteAllRecords()
        let data = AppUser.findOrInsertAppUser(in: masterContext!)
        performSave(context: masterContext!, completionHandler: nil)
        
        return data

    }
    
    
    func saveUserData(data: User) -> Bool {
        guard let oldData = AppUser.findOrInsertAppUser(in: saveContext!) else {
            return false
        }
        
        oldData.userName = data.userName
        oldData.userInfo = data.userInfo
        if let image = data.userImage!.pngData() {
            oldData.userImage = image
        }
        performSave(context: saveContext, completionHandler: nil)
        
        return true
    }
    
    
}

extension AppUser {
    
//    static func findOrInsertAppUser()
    
//    func readUserData() -> User? {
//
//    }
    
    
    static func fetchRequestAppUser(model: NSManagedObjectModel) -> NSFetchRequest<AppUser>? {
        let templateName = "AppUser"
        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<AppUser> else {
            print(false, "No template with name \(templateName)!")
            return nil
        }
//        guard let request = model.fetch
        return fetchRequest
    }
    
//    static func insertAppUser(in context: NSManagedObjectContext) -> AppUser? {
//        guard let appUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser else { return nil
//        }
////        if let image = data.userImage!.pngData() {
////            appUser.userImage = image
////        }
//        appUser.userName = "хуй"
//        appUser.userInfo = "пизда"
////        performSave(context: context, completionHandler: nil)
//
//        return appUser
//    }
    
//    static func insertAppUser(in context: NSManagedObjectContext) -> AppUser? {
//        if let appUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser {
//            appUser.userName = "хуй"
//            appUser.userInfo = "пизда"
//            return appUser
//        } else { return nil
//        }
//        //        if let image = data.userImage!.pngData() {
//        //            appUser.userImage = image
//        //        }
//
//        //        performSave(context: context, completionHandler: nil)
//
//    }
    
    static func insertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        guard let appUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser else { print("cannot insert a record")
            return nil
        }
        return appUser
    }
    
    
    
    
//    static func findOrInsertAppUser(in context: NSManagedObjectContext) -> AppUser? {
//        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
//            print("model is unavailable in this cotext!")
//            assert(false)
//            return nil
//        }
//
//        var appUser: AppUser?
////
////        let fetchRequest = AppUser.fetchRequestAppUser(model: model)
//
////        let results
////        let result = try managedObjectContext.executeRequest(request)
//
//        if let fetchResult = AppUser.fetchRequestAppUser(model: model) {
//            do {
//                let results = try context.fetch(fetchResult)
//                print(results.count)
//                var test = User()
//                var result = results.first
//                test.userName = result?.userName
//                test.userInfo = result?.userInfo
//                print ("пидоры")
//                print (test.userName)
//                print (test.userInfo)
//                assert(results.count<2, "multiple appUsersFound!")
////                if results.count==12{
////                    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "AppUser")
////                    let request = NSBatchDeleteRequest(fetchRequest: fetch)
////                }
//
//
//                if let userFound = results.first {
//                    appUser = userFound
//                    print("user found")
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//
//        } else {
//
//            if appUser == nil {
//                appUser = AppUser.insertAppUser(in: context)
//                print("user inserted")
//            }
//        }
//
//        return appUser
//    }
    
    
    static func findOrInsertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not available in the context!")
            assert(false)
            return nil
        }
        
        var appUser: AppUser?
        guard let fetchRequest = AppUser.fetchRequestAppUser(model: model) else {
            return nil
        }
        
        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count<2, "multiple appUsersFound!")
            if let foundUser = results.first {
                appUser = foundUser
            }
        } catch {
            print("Failed to fetch AppUser:\(error)")
        }
        
        if appUser == nil {
            appUser = AppUser.insertAppUser(in: context)
        }
        
        return appUser
    }

}
