//
//  ConversationTableViewCell.swift
//  Chat
//
//  Created by Dmitry Bakulin on 05.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
    
  //  var log = LoggingLifeCycle()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var indexLabel: UILabel!
    
    override func awakeFromNib() {
  //      log.printMethod()
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

  //      log.printMethod()
        // Configure the view for the selected state
    }
    
}
