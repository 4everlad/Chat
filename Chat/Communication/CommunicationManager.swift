//
//  CommunicationManager.swift
//  Chat
//
//  Created by Dmitry Bakulin on 02/11/2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import Foundation

class CommunicationManager: CommunicatorDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var communicator: MultipeerCommunicator!
    
    var userConversations: [String:ConversationModel] = [:]
    
//    var storageManager : StorageManager!
    
    var delegate: ConversationDelegate!
    
    var onlineConversations : [String:ConversationModel] = [:]
    
    var historyConversations : [String:ConversationModel] = [:]
    
//    func testConversations() {
//        var conversations = [ConversationModel]()
//        let conversation1 = ConversationModel()
//        let conversation2 = ConversationModel()
//        let conversation3 = ConversationModel()
//        conversation1.name = "Johnatan"
//        conversation1.userID = "1"
//        conversation2.name = "Hulio"
//        conversation2.userID = "2"
//        conversation3.name = "monsieur Pijon"
//        conversation3.userID = "3"
//        conversations.append(conversation1)
//        conversations.append(conversation2)
//        //        self.storageManager.testUser()
//        self.storageManager.readDataForConversations()
//        self.storageManager.saveDataForConversations(for: conversations)
//    }
    
    func didFoundUser(UserID: String, userName: String) {
        
        if historyConversations[UserID] == nil {
            let conversation = ConversationModel()
            conversation.name = userName
            conversation.online = true
            conversation.messages = [MessageModel]()
            onlineConversations[UserID] = conversation
            userConversations[UserID] = conversation
            delegate?.updateTableView()
        } else {
            onlineConversations[UserID] = historyConversations[UserID]
//            historyConversations[UserID]!.online = true
        }
        
    }
    
    func didLostUser(userID: String) {
        
        historyConversations[userID] = onlineConversations[userID]
        onlineConversations[userID] = nil
        userConversations[userID] = nil
        delegate?.updateTableView()
        print ("Lost User")
        
    }
    
    func failedToStartBrowsingForUsers(error: Error) {
        print(error.localizedDescription)
    }
    
    func failedToStartAdvertising(error: Error) {
        print(error.localizedDescription)
    }
    
    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
        print("receive")
        
        let message = MessageModel(text: text, mType: .from)
        userConversations[fromUser]?.message = text
        userConversations[fromUser]?.messages?.append(message)
        delegate.updateTableView()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateTableView"), object: nil)
        
    }
    
    func sendMessage(string: String, toUserID: String, completionHandler : ((_ success : Bool,_ error : Error?) -> ())?) {
        communicator.sendMessage(string: string, toUserID: toUserID, completionHandler: completionHandler)
    }
    
//    deinit {
//        self.storageManager.saveDataForConversations(for: <#T##[ConversationModel]#>)
//    }
    
    init() {
        
//        storageManager = StorageManager()
        
//        appDelegate.storageManager.delegate = self
        
        historyConversations = appDelegate.storageManager.readDataForConversations()
        appDelegate.storageManager.readDataForConversations()
//        self.testConversations()
    
        communicator = MultipeerCommunicator()
        communicator.delegate = self
        
        communicator.browser.startBrowsingForPeers()
        communicator.advertiser.startAdvertisingPeer()
        
    }
    
}
