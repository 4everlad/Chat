//
//  MultipeerCommunicator.swift
//  Chat
//
//  Created by Dmitry Bakulin on 25/10/2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MultipeerCommunicator: NSObject, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate {

    var session: MCSession!
    var peer: MCPeerID!
    var browser: MCNearbyServiceBrowser!
    var advertiser: MCNearbyServiceAdvertiser!

    var delegate: MPCManagerDelegate?

    var foundPeers = [MCPeerID]()

    var peerDictionary: [MCPeerID:String] = [:]

    var invitationHandler: ((Bool, MCSession?)->Void)!

    func sendData(dictionaryWithData dictionary: String, toPeer peersIDs: MCPeerID) -> Bool  {
        let dataToSend = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        let peersArray = [peersIDs]

        if session.connectedPeers.count > 0 {
            do {
                try session.send(dataToSend, toPeers: peersArray, with: .reliable)
            }
            catch {
                print("Sending error")
                return false
            }
        }

        return true
    }
    
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        self.invitationHandler = invitationHandler

        delegate?.invitationWasReceived(fromPeer: peerID.displayName)
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
        print("receiving data")

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "receiveData"), object: data)
        
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

    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        var isFound = false
        for (index, _) in [foundPeers].enumerated() {
            if !foundPeers.isEmpty && foundPeers[index] == peerID {
                print("foundPeer: \(foundPeers[index].displayName)")
                isFound = true
                break
            }
        }
        if isFound != true {
            foundPeers.append(peerID)
            peerDictionary[peerID] = info?["userName"]
        }

        print("found user\(foundPeers.count)")
        delegate?.foundPeer()
    }


    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        for (index, _) in [foundPeers].enumerated() {
            if foundPeers[index] == peerID {
                foundPeers.remove(at: index)
                peerDictionary.removeValue(forKey: peerID)
                break
            }
            
        }

        delegate?.lostPeer()
    }

    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print(error.localizedDescription)
    }

    override init() {
        super.init()

        peer = MCPeerID(displayName: UIDevice.current.name)

        session = MCSession(peer: peer)
        session.delegate = self

        browser = MCNearbyServiceBrowser(peer: peer, serviceType: "tinkoff-chat")
        browser.delegate = self

        advertiser = MCNearbyServiceAdvertiser(peer: peer, discoveryInfo: ["userName": "Dmitry"], serviceType: "tinkoff-chat")
        advertiser.delegate = self
    }
}

