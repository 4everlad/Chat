//
//  Message.swift
//  Chat
//
//  Created by Dmitry Bakulin on 08.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import Foundation

class Message {
    var text : String?
    
    enum messageType {
        case from
        case to
    }
    
    var date: Date
    
    let mType: messageType
    
    init(text: String, mType: messageType) {
        self.text = text
        self.mType = mType
        date = Date()
    }
}
