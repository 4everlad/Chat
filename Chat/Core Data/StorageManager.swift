//
//  StorageManager.swift
//  Chat
//
//  Created by Dmitry Bakulin on 06/11/2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import Foundation
import CoreData


class StorageManager: CoreDataStack {
    
    static let sharedStorageManager = StorageManager()
    let stack = CoreDataStack.shared
    let masterCntxt: NSManagedObjectContext!
    let mainCntxt: NSManagedObjectContext!
    let saveCntxt: NSManagedObjectContext!
    let model: NSManagedObjectModel!
    
    override init () {
        masterCntxt = stack.masterContext
        mainCntxt = stack.mainContext
        saveCntxt = stack.saveContext
        model = stack.managedObjectModel
    }
    
    func readDataForUsers() -> [UserModel] {
        var userData = [UserModel]()
        if let data = User.getUsers(in: masterCntxt!) {
            for user in data {
                let userToModel = UserModel()
                userToModel.userName = user.name
//                print(userToModel.userName)
                userToModel.userInfo = user.info
                
                if let image = user.image {
                    userToModel.userImage = UIImage(data: image)
                }
                userData.append(userToModel)
            }
        }
        
        return userData
    }
    
    func deleteConversations() {
        let fetchRequest: NSFetchRequest <Conversation> = Conversation.fetchRequest()
//        fetchRequest.predicate = Predicate.init(format: "profileID==\(withID)")
        let objects = try! masterCntxt.fetch(fetchRequest)
        for obj in objects {
            masterCntxt.delete(obj)
        }
        
        do {
            try masterCntxt.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
    }
    
    func readDataForConversations() -> [String : ConversationModel] {
        var conversationData = [String : ConversationModel]()
        if let data = Conversation.getConversations(in: masterCntxt!) {
            for conversation in data {
                let conversationToModel = ConversationModel()
                conversationToModel.name = conversation.name
                print("conversation name: \(conversationToModel.name)")
//                print(userToModel.userName)
                conversationToModel.message = conversation.message
                conversationToModel.date = conversation.date
                conversationToModel.hasUnreadMessages = conversation.hasUnreadMessages
                conversationToModel.online = conversation.online
                
//                if let image = user.image {
//                    userToModel.userImage = UIImage(data: image)
//                }
                if let userID = conversation.userID {
                    conversationData[userID] = conversationToModel
                }
            }
        }
        
        return conversationData
    }
    
    func saveDataForConversations(for conversations: [String:ConversationModel]) -> Bool {
        
        var newConversations = [String:ConversationModel]()
        if let oldConversations = Conversation.getConversations(in: saveCntxt) {
            if oldConversations.count != 0 {
                for (userID, conversation) in conversations {
//                    let userID = conversation.userID
                    //                let numberOfOldConverations = oldConversations.count
                    var conversationIsFound = false
                    for index in 0...oldConversations.count-1 {
                        var oldConversation = Conversation()
                        oldConversation = oldConversations[index]
                        let anotherUserID = oldConversation.userID
                        if anotherUserID == userID {
                            oldConversations[index].name = conversation.name
                            /// add the rest data
                            conversationIsFound = true
                            break
                        }
                    }
                    if conversationIsFound == false {
                        newConversations[userID] = conversation
                    }
                }
                for (userID, conversation) in newConversations {
                    let insertNewConversation = NSEntityDescription.insertNewObject(forEntityName: "Conversation",
                                                                                    into: saveCntxt) as! Conversation
                    insertNewConversation.userID = userID
                    insertNewConversation.name = conversation.name
                    /// add the rest data
                }
                performSave(context: saveCntxt, completionHandler: nil)
            } else {
                for (userID, conversation) in conversations {
                    let insertNewConversation = NSEntityDescription.insertNewObject(forEntityName: "Conversation",
                                                                                    into: saveCntxt) as! Conversation
                    insertNewConversation.userID = userID
                    insertNewConversation.name = conversation.name
                    /// add the rest data
                }
                performSave(context: saveCntxt, completionHandler: nil)
            }
            
//            return true
        } else {
            return false
//            return true
        }
        return true
    }
    
    
    func testUser() {
        let userJohn = NSEntityDescription.insertNewObject(forEntityName: "Conversation",
                                                           into: mainCntxt) as! Conversation
        userJohn.name = "John Doe"
        
        let userAlice = NSEntityDescription.insertNewObject(forEntityName: "Conversation",
                                                            into: mainCntxt) as! Conversation
        userAlice.name = "Alice"
        
        let userBob = NSEntityDescription.insertNewObject(forEntityName: "Conversation",
                                                          into: mainCntxt) as! Conversation
        userBob.name = "Bob"
        
        performSave(context: mainCntxt, completionHandler: nil)
    }
    
//    func saveUserData(data: UserModel) -> Bool {
//        guard let oldData = User.getUser(in: saveContext!) else {
//            return false
//        }
//
//        oldData.name = data.userName
//        oldData.info = data.userInfo
//        if let image = data.userImage!.pngData() {
//            oldData.image = image
//        }
//        performSave(context: saveContext, completionHandler: nil)
//
//        return true
//    }
    
//    func saveDatafo(data: UserModel) -> Bool {
//        guard stack.saveUserData(data: data) else {
//            return false
//        }
//        return true
//    }
    
}

extension User {
    
    static func fetchRequestUser(model: NSManagedObjectModel) -> NSFetchRequest<User>? {
        let templateName = "User"
        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<User> else {
            print(false, "No template with name \(templateName)!")
            return nil
        }
        
        return fetchRequest
    }
    
    static func getUsers(in context: NSManagedObjectContext) -> [User]? {
        
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not available in the context!")
            assert(false)
            return nil
        }
        
        var users = [User]()
        guard let fetchRequest = User.fetchRequestUser(model: model) else {
            return nil
        }
        
        do {
            let results = try context.fetch(fetchRequest)
            for user in results {
                users.append(user)
            }
            
        } catch {
            print("Failed to fetch AppUser:\(error)")
        }
        
        
        
        print("")
        
        return users
    }
}

extension Conversation {
    static func fetchRequestConversation(model: NSManagedObjectModel) -> NSFetchRequest<Conversation>? {
        let templateName = "Conversation"
        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<Conversation> else {
            print(false, "No template with name \(templateName)!")
            return nil
        }
        
        return fetchRequest
    }
    
    static func getConversations(in context: NSManagedObjectContext) -> [Conversation]? {
        
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not available in the context!")
            assert(false)
            return nil
        }
        
        var conversations = [Conversation]()
        guard let fetchRequest = Conversation.fetchRequestConversation(model: model) else {
            return nil
        }
        
        do {
            let results = try context.fetch(fetchRequest)
            for conversation in results {
                conversations.append(conversation)
            }
            
        } catch {
            print("Failed to fetch AppUser:\(error)")
        }
        
        print("")
        
        return conversations
    }
}
