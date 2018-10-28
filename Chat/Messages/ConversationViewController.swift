//
//  ConversationViewController.swift
//  Chat
//
//  Created by Dmitry Bakulin on 08.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    
    var cellTitle: String?
    
    var message: String?
    
    var messages = [Message]()
    
    var messagesArray: [Dictionary<String, String>] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func addConversations() {
        
        messages.append(Message(text: "Здравствуйте вавоавоаоваоваasd efefwef fdsfsdfs sdfsdfsdf sdfs вараврва оваовао ваовао ", mType: .from))
        messages.append(Message(text: "Здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте ", mType: .from))
        messages.append(Message(text: "Здравствуйте вавоавоаоваова sdfs здравствуйте здравствуйте здравствуйте ", mType: .to))
        messages.append(Message(text: "Здравствуйте вавоавоаоваова sd", mType: .from))
        messages.append(Message(text: "Здрdv dssdfsd sdf sdf fsdf fsdf sdf ", mType: .to))
        messages.append(Message(text: "Здравствуйте вавоавоаsdfs sdf sdf ", mType: .from))
        messages.append(Message(text: "вавоавоаsdfs sdf sdf ысысвсывс", mType: .from))
        
    }
    
    
    func handleMPCReceivedDataWithNotification(notification: NSNotification) {
        
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
    
        let data = receivedDataDictionary["data"] as? NSData
        let fromPeer = receivedDataDictionary["fromPeer"] as! MCPeerID
        
        let dataDictionary = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as! Dictionary<String, String>
        
        if let message = dataDictionary["message"] {
            
        var messageDictionary: [String: String] = ["sender": fromPeer.displayName, "message": message]
        messagesArray.append(messageDictionary)
        self.updateTableview()
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let messageDictionary: [String: String] = ["message": textField.text!]
        let peerToSend = appDelegate.mpcManager.session.connectedPeers[0]
        
        if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: peerToSend) {
            var dictionary: [String: String] = ["sender": "self", "message": textField.text!]
            messagesArray.append(dictionary)
            print("message array: \(messagesArray)")
        }
            
        self.updateTableview()
//        else{
//            print("Could not send data")
//        }
        
        textField.text = ""
        
        return true
    }

    func updateTableview(){
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let message = messages[indexPath.row]
//
//        switch message.mType {
//        case .from:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FromMessageCell", for: indexPath) as! FromMessageTableViewCell
//            cell.textMessage = message.text
//            return cell
//        case .to:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ToMessageCell", for: indexPath) as! ToMessageTableViewCell
//            cell.textMessage = message.text
//            return cell
//        }

        let message = messagesArray[indexPath.row] as Dictionary<String, String>
        let sender = message["sender"]
            if sender == "self" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ToMessageCell", for: indexPath) as! ToMessageTableViewCell
                cell.textMessage = message["message"]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FromMessageCell", for: indexPath) as! FromMessageTableViewCell
                cell.textMessage = message["message"]
                return cell
            }
    }
    

    
    @IBOutlet var messageTextField: UITextField!
    

    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = cellTitle
        
        addConversations()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.register(UINib(nibName: "FromMessageTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "FromMessageCell")
        
        tableView.register(UINib(nibName: "ToMessageTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ToMessageCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        
        messageTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: "handleMPCReceivedDataWithNotification:", name: NSNotification.Name(rawValue: "receivedMPCDataNotification"), object: nil)

//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleMPCReceivedDataWithNotification:", name: "receivedMPCDataNotification", object: nil)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
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
