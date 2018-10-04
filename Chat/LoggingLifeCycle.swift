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
    
    static var isLogging = true // turns logging on/off
    
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
    
    func logMethod(methodName: String = #function) -> String {
        let mName = methodName
        return mName
    }
    
    func printStateAndMethod() {
        if LoggingLifeCycle.isLogging {
            print("Application moved from <\(previousState)> to <\(logState())>: <\(logMethod())>")
        } else {
            print("Logging is off")
        }
    }
    
    func printMethod() {
        if LoggingLifeCycle.isLogging {
            print("ViewController method: <\(logMethod())>")
        } else {
            print("Logging is off")
        }
    }
    
    init() {
        previousState = logState()
    }
}
