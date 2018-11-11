//
//  MultipeerCommunicator.swift
//  Chat
//
//  Created by Dmitry Bakulin on 25/10/2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MultipeerCommunicator: NSObject, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate, Communicator  {
    
    
    func sendMessage(string: String, toUserID: String, completionHandler : ((_ success : Bool,_ error : Error?) -> ())?) {
        
        if let peerID = peerDictionary[toUserID] {
            let session = sessions[toUserID]
            let peersArray = [peerID]
            let dataToSend = NSKeyedArchiver.archivedData(withRootObject: string)
            if session!.connectedPeers.count > 0 {
                do {
                    try session!.send(dataToSend, toPeers: peersArray, with: .reliable)
                }
                catch {
                    print(error.localizedDescription)
//                    return false
                }
            }
        } else {
            print("Sending message is imposible, peerID is nil")
        }
    }
    
    weak var delegate: CommunicatorDelegate?
    
    var online = true

//    var session: MCSession!
//    var sessions: [MCSession]!
    var peer: MCPeerID!
    var browser: MCNearbyServiceBrowser!
    var advertiser: MCNearbyServiceAdvertiser!

//    var foundPeers = [MCPeerID]()

    var sessions: [String:MCSession] = [:]
    var peerDictionary: [String:MCPeerID] = [:]
    
    
    
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
        let userID = peerID.displayName
        if peerDictionary[userID] == nil {
            peerDictionary[userID] = peerID
            let session = MCSession(peer: peer)
            session.delegate = self
            sessions[userID] = session
//            sessions.append(session)
            
            browser.invitePeer(peerID,
                               to: session,
                               withContext: nil,
                               timeout: 30)
            let userName = info?["userName"]
            
            delegate?.didFoundUser(UserID: userID, userName: userName!)
        }
        
        
        
//                var isFound = false
//                for (index, _) in [foundPeers].enumerated() {
//                    if !foundPeers.isEmpty && foundPeers[index] == peerID {
//                        print("foundPeer: \(foundPeers[index].displayName)")
//                        isFound = true
//                        break
//                    }
//                }
//                if isFound != true {
//                    foundPeers.append(peerID)
//                    peerDictionary[peerID] = peerID.displayName
//                    browser.invitePeer(peerID,
//                                       to: session,
//                                       withContext: nil,
//                                       timeout: 30)
//
//                    if let userName = info?["userName"] {
//                        delegate?.didFoundUser(UserID: peerID.displayName, userName: userName)
//                    }
//
//                }
        
    }
    
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
        peerDictionary.removeValue(forKey: peerID.displayName)
        sessions.removeValue(forKey: peerID.displayName)
        delegate?.didLostUser(userID: peerID.displayName)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        delegate?.failedToStartBrowsingForUsers(error: error)
        print(error.localizedDescription)
    }
    
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
//        self.invitationHandler = invitationHandler
        let session = sessions[peerID.displayName]
//        if session!.connectedPeers.contains(peerID) {
//            invitationHandler(false, nil)
//        } else {
//            invitationHandler(true, session)
//        }
        invitationHandler(true, session)
        print("Invitation Was Received")
        
//        delegate?.invitationWasReceived(fromPeer: peerID.displayName)
    }

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print(error.localizedDescription)
    }

    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print("session state")
        switch state{
        case MCSessionState.connected:
            print("Connected to session: \(session)")

        case MCSessionState.connecting:
            print("Connecting to session: \(session)")

        default:
            print("Did not connect to session: \(session)")
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
//        print("receiving data")
        let receivedMessage = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! String
        delegate?.didReceiveMessage(text: receivedMessage, fromUser: peerID.displayName, toUser: peer.displayName)
        
        
    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("adv")
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("adv")
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print("adv")
    }

    

    override init() {
        super.init()

        peer = MCPeerID(displayName: UIDevice.current.name)

        browser = MCNearbyServiceBrowser(peer: peer, serviceType: "tinkoff-chat")
        browser.delegate = self

        advertiser = MCNearbyServiceAdvertiser(peer: peer, discoveryInfo: ["userName": "Dmitry"], serviceType: "tinkoff-chat")
        advertiser.delegate = self
    }
}



