//
//  ConversationsListViewController.swift
//  Chat
//
//  Created by Dmitry Bakulin on 06.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var conversations = [Conversation]()
    
    var onlineConversations: [Conversation] {
        get {
            return conversations.filter { $0.online }
        }
    }
    
    var historyConversations: [Conversation] {
        get {
            return conversations.filter { $0.online == false && $0.message != nil }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    func addConversations() {
        
        conversations.append(Conversation(name: "Иван", message: nil, date: Date(), online: true, hasUnreadMessages: false))
        conversations.append(Conversation(name: "Лена", message: "раз два три четыре пять", date: Date(), online: true, hasUnreadMessages: false))
        conversations.append(Conversation(name: "Пижон", message: "Здорова", date: Date(), online: true, hasUnreadMessages: true))
        conversations.append(Conversation(name: "Бекмамбет", message: "Здравствуйте уважаемый", date: Date(), online: true, hasUnreadMessages: true))
        conversations.append(Conversation(name: "Тристан", message: "ыварвраырваывра", date: Date(), online: false, hasUnreadMessages: true))
        conversations.append(Conversation(name: "Валерка", message: "вататаыта", date: Date(), online: false, hasUnreadMessages: true))
        conversations.append(Conversation(name: "Кебаб", message: nil, date: Date(), online: false, hasUnreadMessages: false))
        conversations.append(Conversation(name: "Хабиб", message: "вввввв", date: Date(), online: true, hasUnreadMessages: false))
        conversations.append(Conversation(name: "Приор", message: "ввава", date: Date(), online: true, hasUnreadMessages: true))
        conversations.append(Conversation(name: "Ташкент", message: "Здравствуйте", date: Date(), online: true, hasUnreadMessages: true))
        conversations.append(Conversation(name: "Анатолий", message: "Здравствуйте", date: Date(), online: true, hasUnreadMessages: true))
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(conversations.count)
//        return conversations.count
        
        if section == 0 {
            return onlineConversations.count
        }
        else {
            return historyConversations.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // TODO: HeaderSection
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Online" }
        else if section == 1 {
            return "History"
        } else { return nil }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationTableViewCell
        
        var conversation: Conversation!
        
        if indexPath.section == 0 {
            conversation = onlineConversations[indexPath.row]
        } else if indexPath.section == 1 {
            conversation = historyConversations[indexPath.row]
        }
        
        cell.nameLabel.text = conversation.name
        
        // Если передан nil?
        if let lastMessage = conversation.message {
            cell.messageLabel.text = lastMessage
        } else {
            cell.messageLabel.text = "No messages yet"
            cell.messageLabel.font = UIFont(name:"Arial", size: 20)
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        cell.dateLabel.text = formatter.string(for: conversation.date)
        
        cell.indexLabel.text = String(indexPath.row)
        
        if conversation.online {
            let yellowColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 153/255.0, alpha: 1.0)
            cell.backgroundColor = yellowColor
        }
        
        if conversation.hasUnreadMessages {
            cell.messageLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        }
        
        return cell
    }
    

    override func viewDidLoad() {
        addConversations()
        
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.register(UINib(nibName: "ConversationTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ConversationCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
//    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
//        NSLog("did select and the text is \(cell?.textLabel?.text)")
//    }
    
//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = self.tableView.cellForRow(at: indexPath)
//    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowConversationSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                print("\(indexPath.row)")
                let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationTableViewCell
                print("cell:\(cell.messageLabel.text)")
                print("name:\(cell.nameLabel.text)")
                let cellTitle = cell.nameLabel.text
                if let destinationViewController = segue.destination as? ConversationViewController {
                    destinationViewController.cellTitle = cellTitle
                }
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
//
//        // Get the index path from the cell that was tapped
//        let indexPath = tableView.indexPathForSelectedRow
//        // Get the Row of the Index Path and set as index
//        let index = indexPath?.row
//        // Get in touch with the DetailViewController
//        let detailViewController = segue.destinationViewController as! DetailViewController
//        // Pass on the data to the Detail ViewController by setting it's indexPathRow value
//        detailViewController.index = index
//    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowConversationSegue", sender: nil)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
