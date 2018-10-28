//
//  CommunicatorDelegate.swift
//  Chat
//
//  Created by Dmitry Bakulin on 25/10/2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import Foundation
import MultipeerConnectivity

//protocol CommunicatorDelegate: Class {
//    //discovering
//    func didFoundUser(UserID : String, userName : String?)
//    func didLostUser(userID : String)
//    
//    //errors
//    func failedToStartBrowsingForUsers(error: Error)
//    func failedToStartAdvertising(error: Error)
//    
//    //messages
//    func didReceiveMessage(text: String, fromUser: String, toUser: String)
//}

protocol MPCManagerDelegate {
    func foundPeer()
    
    func lostPeer()
    
    func invitationWasReceived(fromPeer: String)
    
    func connectedWithPeer(peerID: MCPeerID)
}
