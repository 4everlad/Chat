//
//  FromMessageTableViewCell.swift
//  Chat
//
//  Created by Dmitry Bakulin on 08.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit

class FromMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!  {
        didSet {
            messageLabel.numberOfLines = 0;
            messageLabel.sizeToFit()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
