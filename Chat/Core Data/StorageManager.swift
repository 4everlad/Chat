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

    func readData() -> User {
        let userData = User()
        if let data = stack.readUserData() {
            userData.userName = data.userName
            userData.userInfo = data.userInfo
            if let image = data.userImage {
                userData.userImage = UIImage(data: image)
            }
        }
        return userData
    }
    
    func saveData(data: User) -> Bool {
        guard stack.saveUserData(data: data) else {
            return false
        }
        return true
    }
}
