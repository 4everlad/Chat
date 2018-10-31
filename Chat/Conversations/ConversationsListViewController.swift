//
//  ConversationsListViewController.swift
//  Chat
//
//  Created by Dmitry Bakulin on 06.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ConversationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ThemesViewControllerDelegate, MPCManagerDelegate, ConversationDelegate {
    
    
    func printCoversation() {
        if !conversations.isEmpty {
            for (key,value) in conversations {
                var lastMessage = value?.last
                print("conversation = \(lastMessage?.text)")
            }
        } else {
            print ("conversations is empty")
        }
        
    }
    
    
    var conversations = [MCPeerID?: [Message]?]()
    
    func addConversation(peerID: MCPeerID, conversation: [Message]) {
        conversations[peerID] = conversation
    }

    func foundPeer() {
        print("foundPeer")
        tableView.reloadData()
    }

    func lostPeer() {
        print("lostPeer")
        tableView.reloadData()
    }
    
    func invitationWasReceived(fromPeer: String) {
        print("invitationWasReceived")
        self.appDelegate.mpcManager.invitationHandler(true, self.appDelegate.mpcManager.session)
    }

    func connectedWithPeer(peerID: MCPeerID) {
        print("connectedWithPeer")
    }
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
//    var onlineConversations: [Conversation] {
//        get {
//            return conversations.filter { $0.online }
//        }
//    }
//
//    var historyConversations: [Conversation] {
//        get {
//            return conversations.filter { $0.online == false && $0.message != nil }
//        }
//    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let peersNumber = appDelegate.mpcManager.foundPeers.count
        print("peer: \(peersNumber)")
        return peersNumber
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "online"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationTableViewCell
        
        let peerID = appDelegate.mpcManager.foundPeers[indexPath.row]
        let userName = appDelegate.mpcManager.peerDictionary[peerID]
        cell.name = userName
        if let messagesInfo = conversations[peerID] {
            if let lastMessage = messagesInfo?.last {
                cell.message = lastMessage.text
                cell.date = lastMessage.date
            }
        }
        
        
//        cell.name = conversation.name
//        cell.message = conversation.message
//        cell.date = Date()
//        cell.online = conversation.online
//        cell.hasUnreadMessages = conversation.hasUnreadMessages
        
        return cell
    }
    

    override func viewDidLoad() {
        
        appDelegate.mpcManager.browser.startBrowsingForPeers()
        appDelegate.mpcManager.advertiser.startAdvertisingPeer()
        
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.backgroundColor = .red
        
        tableView.register(UINib(nibName: "ConversationTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ConversationCell")
        // Do any additional setup after loading the view.
        
        appDelegate.mpcManager.delegate = self
        
        printCoversation()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedPeer = appDelegate.mpcManager.foundPeers[indexPath.row]
//        let peerID = selectedPeer.
        let cellTitle = appDelegate.mpcManager.peerDictionary[selectedPeer]
        
        appDelegate.mpcManager.browser.invitePeer(selectedPeer, to: appDelegate.mpcManager.session, withContext: nil, timeout: 20)
        
        if let conversationVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConversationViewController") as? ConversationViewController {
            conversationVC.cellTitle = cellTitle
            conversationVC.delegate = self
            
            if let navigator = navigationController {
                navigator.pushViewController(conversationVC, animated: true)
                conversations[selectedPeer] = nil
            }
        }
        
    }
    
    func logThemeChanging(selectedTheme: UIColor) {
        
        switch selectedTheme {
        case .red:
            print("selected theme: red")
        case .green:
            print("selected theme: green")
        case .blue:
            print("selected theme: blue")
        default:
            print("selected theme: wrong value")
        }
    
    }
    
    
    func themesViewController(_ controller: ThemesViewController!, didSelectTheme selectedTheme: UIColor!) {
        self.view.backgroundColor = selectedTheme;
        self.logThemeChanging(selectedTheme: selectedTheme)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "ShowConversationSegue" {
    //            if let indexPath = self.tableView.indexPathForSelectedRow {
    //                print("\(indexPath.row)")
    //
    //                var conversation: Conversation!
    //
    //                if indexPath.section == 0 {
    //                    conversation = onlineConversations[indexPath.row]
    //                } else if indexPath.section == 1 {
    //                    conversation = historyConversations[indexPath.row]
    //                }
    //
    //                let cellTitle = conversation.name
    //                if let destinationViewController = segue.destination as? ConversationViewController {
    //                    destinationViewController.cellTitle = cellTitle
    //                }
    //            }
    //        }
    //
    //        if segue.identifier == "ShowThemesSegue" {
    //            if let destinationViewController = segue.destination as? ThemesViewController {
    //                destinationViewController.delegate = self
    //                if let theme = self.view.backgroundColor {
    //                    destinationViewController.currentTheme = theme
    //                }
    //            }
    //        }
    //    }
    
    //    @IBAction func openThemesButton(_ sender: UIBarButtonItem) {
    //
    //        let themesVC = ThemesViewController(
    //                    nibName: "ThemesViewController",
    //                    bundle: nil)
    //                navigationController?.pushViewController(themesVC,
    //                                                         animated: true)
    //    }
}

protocol ConversationDelegate {
    func addConversation(peerID: MCPeerID, conversation: [Message])
    func printCoversation()
}
