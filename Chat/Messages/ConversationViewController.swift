//
//  ConversationViewController.swift
//  Chat
//
//  Created by Dmitry Bakulin on 08.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cellTitle: String?
    
    var message: String?
    
    var messages = [Message]()
    
    func addConversations() {
        
        messages.append(Message(text: "Здравствуйте вавоавоаоваоваasd efefwef fdsfsdfs sdfsdfsdf sdfs вараврва оваовао ваовао ", mType: .from))
        messages.append(Message(text: "Здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте здравствуйте ", mType: .from))
        messages.append(Message(text: "Здравствуйте вавоавоаоваова sdfs здравствуйте здравствуйте здравствуйте ", mType: .to))
        messages.append(Message(text: "Здравствуйте вавоавоаоваова sd", mType: .from))
        messages.append(Message(text: "Здрdv dssdfsd sdf sdf fsdf fsdf sdf ", mType: .to))
        messages.append(Message(text: "Здравствуйте вавоавоаsdfs sdf sdf ", mType: .from))
        messages.append(Message(text: "вавоавоаsdfs sdf sdf ысысвсывс", mType: .from))
        
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
