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
    
    var delegate: ConversationDelegate?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @objc func receiveData(_ notification: Notification) {
        let data = notification.object as! NSData
        let receivedMessage = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! String
        let peerID = appDelegate.mpcManager.session.connectedPeers[0]
        let message = Message(text: receivedMessage, mType: .from)
        
        //var conversation = conversations[peerID]
        //        conversation.append()
        //        conversations[peerID]
        
        
        messages.append(message)
        delegate?.addConversation(peerID: peerID, conversation: messages)
        delegate?.printCoversation()
        
        self.updateTableView()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let messageToSend = textField.text!
        let peerID = appDelegate.mpcManager.session.connectedPeers[0]
        delegate?.printCoversation()
        
        if appDelegate.mpcManager.sendData(dictionaryWithData: messageToSend, toPeer: peerID) {
            let message = Message(text: messageToSend, mType: .to)
            messages.append(message)
            delegate?.addConversation(peerID: peerID, conversation: messages)
        } else {
            return false
        }
        self.updateTableView()
        textField.text = ""
        
        return true
    }

    func updateTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]

        switch message.mType {
        case .from:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FromMessageCell", for: indexPath) as! FromMessageTableViewCell
            cell.textMessage = message.text
            return cell
        case .to:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToMessageCell", for: indexPath) as! ToMessageTableViewCell
            cell.textMessage = message.text
            return cell
        }
    }
    
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var messageTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func sendMessage(_ sender: Any) {
        textFieldShouldReturn(messageTextField)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = cellTitle
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        
        tableView.register(UINib(nibName: "FromMessageTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "FromMessageCell")
        
        tableView.register(UINib(nibName: "ToMessageTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ToMessageCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        
        messageTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveData(_:)), name: NSNotification.Name(rawValue: "receiveData"), object: nil)



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
