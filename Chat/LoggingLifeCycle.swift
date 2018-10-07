//
//  LoggingLifeCycle.swift
//  Chat
//
//  Created by Dmitry Bakulin on 24.09.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit

class LoggingLifeCycle {
    
    var previousState = ""
    
    static var isLogging = false // turns logging on/off
    
    func logState() -> String {

            var state: String
            
            switch UIApplication.shared.applicationState {
                
            case .active:
                state = "active"
            case .inactive:
                state = "inactive"
            case .background:
                state = "background"
                
            }
        
        return state
    }
    
    func printStateAndMethod(methodName: String = #function) {
        if LoggingLifeCycle.isLogging {
            let mName = methodName
            print("Application moved from <\(previousState)> to <\(logState())>: <\(mName)>")
        } else {
            print("Logging is off")
        }
    }
    
    func printMethod(methodName: String = #function) {
        if LoggingLifeCycle.isLogging {
            let mName = methodName
            print("ViewController method: <\(mName)>")
        } else {
            print("Logging is off")
        }
    }
    
    init() {
        previousState = logState()
    }
}
