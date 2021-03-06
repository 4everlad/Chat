//
//  ConversationsListViewController.swift
//  Chat
//
//  Created by Dmitry Bakulin on 06.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ConversationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ThemesViewControllerDelegate, ConversationDelegate {
    
    var communicationManager : CommunicationManager!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
//    var onlineConversations : [ConversationsModel]
    
//    var onlineConversations : [ConversationModel]? {
//        didSet {
//            onlineConversations = communicationManager.
//        }
//    }
    
//    var 
    
    func updateTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
//    func printCoversation() {
//        if !conversations.isEmpty {
//            for (key,value) in conversations {
//                var lastMessage = value?.last
//                print("conversation = \(lastMessage?.text)")
//            }
//        } else {
//            print ("conversations is empty")
//        }
//
//    }
    
    
    @IBOutlet weak var tableView: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

//        let peersNumber = communicationManager.userConversations.count
//        print("peer: \(peersNumber)")
//        return peersNumber
        
        if section == 0 {
            return communicationManager.onlineConversations.count
        }
        else {
            return communicationManager.historyConversations.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if section == 0 {
            return "Online" }
        else if section == 1 {
            return "History"
        } else { return nil }
//        return "online"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationTableViewCell
        
        var conversation: ConversationModel!
        
        if indexPath.section == 0 {
            var userIDs = Array(communicationManager.onlineConversations.keys)
            let userID = userIDs[indexPath.row]
            conversation = communicationManager.onlineConversations[userID]
            
        } else if indexPath.section == 1 {
            var userIDs = Array(communicationManager.historyConversations.keys)
            let userID = userIDs[indexPath.row]
            conversation = communicationManager.historyConversations[userID]
        }
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationTableViewCell
        
//        var userIDs = Array(communicationManager.userConversations.keys)
//        let userID = userIDs[indexPath.row]
//        let conversation = communicationManager.userConversations[userID]
        
        cell.name = conversation?.name
        cell.message = conversation?.message
        cell.date = conversation?.date
        cell.hasUnreadMessages = conversation!.hasUnreadMessages
        cell.online = conversation!.online
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var userIDs = Array(communicationManager.userConversations.keys)
        let userID = userIDs[indexPath.row]
        let conversation = communicationManager.userConversations[userID]
        
        let cellTitle = conversation?.name
        
        if let conversationVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConversationViewController") as? ConversationViewController {
            conversationVC.cellTitle = cellTitle
            conversationVC.delegate = communicationManager
            conversationVC.userID = userID
        
            if let navigator = navigationController {
                navigator.pushViewController(conversationVC, animated: true)
//                conversations[selectedPeer] = nil
            }
        }
        
    }
    
    

    override func viewDidLoad() {
        communicationManager = CommunicationManager()
        
       
        
//        self.storageManager.deleteConversations()
        
        
        communicationManager.delegate = self
        
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.backgroundColor = .red
        
        tableView.register(UINib(nibName: "ConversationTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ConversationCell")
        // Do any additional setup after loading the view.
        
        //appDelegate.mpcManager.delegate = self
        
//        printCoversation()
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let onlineConversations = communicationManager.onlineConversations
        appDelegate.storageManager.saveDataForConversations(for: onlineConversations)
        let historyConversations = communicationManager.historyConversations
        appDelegate.storageManager.saveDataForConversations(for: historyConversations)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
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

//protocol ConversationDelegate {
//    func addConversation(peerID: MCPeerID, conversation: [Message])
//    func printCoversation()
//}

protocol ConversationDelegate {
    func updateTableView()
}
