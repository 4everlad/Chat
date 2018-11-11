//
//  StorageManager.swift
//  Chat
//
//  Created by Dmitry Bakulin on 06/11/2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import Foundation

class StorageManager: CoreDataStack {
    
    let stack = CoreDataStack.shared
//    private let manager = CoreDataStack.sharedInstance
    
//    func readProfile() -> User {
//
//        return
//    }
    
    
//    func insertData(data: User) {
//        if saveUserData(data: data) {
//            print("idite v pizdu")
//        } else {print("idite nahui")}
//    }
    
    func readData() -> User {
        let userData = User()
//        stack.readUserData()
        if let data = stack.readUserData() {
            userData.userName = data.userName
            userData.userInfo = data.userInfo
            if let image = data.userImage {
                userData.userImage = UIImage(data: image)
            }
        }
        return userData
    }
    
//    init () {
//        super.init()
//    }
    
    func saveData(data: User) -> Bool {
        guard stack.saveUserData(data: data) else {
            return false
        }
        return true
    }
}
