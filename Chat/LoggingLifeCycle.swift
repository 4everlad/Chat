//
//  LoggingLifeCycle.swift
//  Chat
//
//  Created by Dmitry Bakulin on 24.09.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit

class LoggingLifeCycle {
    
    static var previousState =  UIApplication.shared.applicationState
    static var currentState =  UIApplication.shared.applicationState
    
    static var isLogging = true
    
    static func logStateAndMethod(methodName: String = #function){
        if isLogging {
            var prevState: String
            var curState: String
            
            currentState =  UIApplication.shared.applicationState
            
            switch previousState {
            case .active:
                prevState = "active"
            case .inactive:
                prevState = "inactive"
            case .background:
                prevState = "background"
                
            }
            
            switch currentState {
            case .active:
                curState = "active"
            case .inactive:
                curState = "inactive"
            case .background:
                curState = "background"
                
            }
            
            print("Application moved from <\(prevState)> to <\(curState)>: <\(methodName)>")
            
            previousState = currentState
        } else {
            print("Logging is off")
        }
    }
    
    static func logMethod(methodName: String = #function) {
        if isLogging {
            print("ViewController method: <\(methodName)>")
        } else {
            print("Logging is off")
        }
    }
    
}
