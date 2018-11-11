//
//  CommunicationManager.swift
//  Chat
//
//  Created by Dmitry Bakulin on 02/11/2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import Foundation

class CommunicationManager: CommunicatorDelegate {
    
    var communicator: MultipeerCommunicator!
    
    var userConversations: [String:Conversation] = [:]
    
    var delegate: ConversationDelegate!
    
    func didFoundUser(UserID: String, userName: String) {
        
        let conversation = Conversation()
        conversation.name = userName
        conversation.online = true
        conversation.messages = [Message]()
        userConversations[UserID] = conversation
        delegate?.updateTableView()
        
    }
    
    func didLostUser(userID: String) {
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
        
        let message = Message(text: text, mType: .from)
        userConversations[fromUser]?.message = text
        userConversations[fromUser]?.messages?.append(message)
        delegate.updateTableView()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateTableView"), object: nil)
        
    }
    
    func sendMessage(string: String, toUserID: String, completionHandler : ((_ success : Bool,_ error : Error?) -> ())?) {
        communicator.sendMessage(string: string, toUserID: toUserID, completionHandler: completionHandler)
    }
    
    init() {
    
        communicator = MultipeerCommunicator()
        communicator.delegate = self
        
        communicator.browser.startBrowsingForPeers()
        communicator.advertiser.startAdvertisingPeer()
        
    }
    
}
