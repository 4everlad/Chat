//
//  ConversationTableViewCell.swift
//  Chat
//
//  Created by Dmitry Bakulin on 05.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit

class ConversationTableViewCell: UITableViewCell, ConversationCellConfiguration {
    
    var name: String? {
        didSet {
            nameLabel.text = self.name
        }
    }
    
    var message: String? {
        didSet {
            if let lastMessage = message {
                messageLabel.text = lastMessage
            } else {
                messageLabel.text = "No messages yet"
                messageLabel.font = UIFont(name:"Arial", size: 17)
            }
        }
    }
    
    var date: Date? {
        didSet {
            if date != nil {
                let secondsAgo = Int(Date().timeIntervalSince(date!))
                let day = 24 * 60 * 60
                let formatter = DateFormatter()
                
                if secondsAgo < day {
                    formatter.dateFormat = "HH:mm"
                    dateLabel.text = formatter.string(for: date)
                } else {
                    formatter.dateFormat = "dd MMM"
                    dateLabel.text = formatter.string(for: date)
                }
            }
            
        }
    }
    
    var online = false {
        didSet {
            if online {
                let yellowColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 153/255.0, alpha: 1.0)
                backgroundColor = yellowColor
            } else {
                backgroundColor = .white
            }
        }
    }
    
    var hasUnreadMessages = false {
        didSet {
            if hasUnreadMessages {
                messageLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            } else {
                messageLabel.font = UIFont.systemFont(ofSize: 17)
            }
        }
    }
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

  //      log.printMethod()
        // Configure the view for the selected state
    }
    
}
