//
//  ConversationsListViewController.swift
//  Chat
//
//  Created by Dmitry Bakulin on 06.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ThemesViewControllerDelegate  {
    
    
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
        
        let inFormatter = DateFormatter()
        inFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        
        var inStr = "10-16-2018 18:32"
        var date = inFormatter.date(from: inStr)!
        conversations.append(Conversation(name: "Иван", message: nil, date: date, online: true, hasUnreadMessages: false))
        inStr = "10-15-2018 12:32"
        date = inFormatter.date(from: inStr)!
        conversations.append(Conversation(name: "Лена", message: "раз два три четыре пять", date: date, online: true, hasUnreadMessages: false))
        inStr = "09-17-2018 12:32"
        date = inFormatter.date(from: inStr)!
        conversations.append(Conversation(name: "Пижон", message: "Здорова", date: date, online: true, hasUnreadMessages: true))
        inStr = "10-17-2017 12:32"
        date = inFormatter.date(from: inStr)!
        conversations.append(Conversation(name: "Бекмамбет", message: "Здравствуйте уважаемый", date: date, online: true, hasUnreadMessages: true))
        inStr = "10-10-2018 12:32"
        date = inFormatter.date(from: inStr)!
        conversations.append(Conversation(name: "Хабиб", message: "вввввв", date: date, online: true, hasUnreadMessages: false))
        inStr = "10-17-2018 12:32"
        date = inFormatter.date(from: inStr)!
        conversations.append(Conversation(name: "Приор", message: "ввава", date: date, online: true, hasUnreadMessages: true))
        inStr = "10-17-2018 12:32"
        date = inFormatter.date(from: inStr)!
        conversations.append(Conversation(name: "Ташкент", message: "Здравствуйте", date: date, online: true, hasUnreadMessages: true))
        conversations.append(Conversation(name: "Анатолий", message: "Здравствуйте", date: Date(), online: true, hasUnreadMessages: true))
        conversations.append(Conversation(name: "Илон", message: "С пацанами ракету вчера взорвали", date: Date(), online: true, hasUnreadMessages: false))
        
        conversations.append(Conversation(name: "Тристан", message: "ыварвраырваывра", date: Date(), online: false, hasUnreadMessages: true))
        conversations.append(Conversation(name: "Валерка", message: "вататаыта", date: Date(), online: false, hasUnreadMessages: true))
        conversations.append(Conversation(name: "Кебаб", message: nil, date: Date(), online: false, hasUnreadMessages: false))
        conversations.append(Conversation(name: "Виктор", message: nil, date: Date(), online: false, hasUnreadMessages: false))
        conversations.append(Conversation(name: "Анастасия", message: "раз два три четыре пять шесть семь восемь девять десять одиннадцать", date: Date(), online: false, hasUnreadMessages: false))
        conversations.append(Conversation(name: "Данила", message: nil, date: Date(), online: false, hasUnreadMessages: false))
        conversations.append(Conversation(name: "Юлия", message: "Приветствую, записываемся на татауировочки", date: Date(), online: false, hasUnreadMessages: false))
        conversations.append(Conversation(name: "Ринат", message: "Вот шлем себе купил", date: Date(), online: false, hasUnreadMessages: true))
        conversations.append(Conversation(name: "Клавдия", message: "Хлеба сходи купи", date: Date(), online: false, hasUnreadMessages: true))
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
        
        cell.name = conversation.name
        cell.message = conversation.message
        cell.date = conversation.date
        cell.online = conversation.online
        cell.hasUnreadMessages = conversation.hasUnreadMessages
        
        return cell
    }
    

    override func viewDidLoad() {
        addConversations()
        
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.backgroundColor = .red
        
        tableView.register(UINib(nibName: "ConversationTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ConversationCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowConversationSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                print("\(indexPath.row)")
                
                var conversation: Conversation!
                
                if indexPath.section == 0 {
                    conversation = onlineConversations[indexPath.row]
                } else if indexPath.section == 1 {
                    conversation = historyConversations[indexPath.row]
                }
                
                let cellTitle = conversation.name
                if let destinationViewController = segue.destination as? ConversationViewController {
                    destinationViewController.cellTitle = cellTitle
                }
            }
        }
        
        if segue.identifier == "ShowThemesSegue" {
            if let destinationViewController = segue.destination as? ThemesViewController {
                destinationViewController.delegate = self
                if let theme = self.view.backgroundColor {
                    destinationViewController.currentTheme = theme
                }
            }
        }
        
        
    }

    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "ShowConversationSegue", sender: nil)
//
//        let conversationViewController = ConversationViewController()
//        navigationController?.pushViewController(conversationViewController, animated: true)
//    }
    
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

}
