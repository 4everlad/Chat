//
//  GCDDataManager.swift
//  Chat
//
//  Created by Dmitry Bakulin on 20.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import Foundation

class GCDDataManager {
    
    var userName: String?
    var userInfo: String?
    var userImage: UIImage?
    
    let userInitiatedQueue = DispatchQueue(label: "com.chat.queue", qos: .userInitiated, attributes: .concurrent)
    
    func readData() {
        userInitiatedQueue.sync {
            let defaults = UserDefaults.standard
            if let name = defaults.string(forKey: "userName") {
                userName = name
            } else { userName = nil }
            
            if let info = defaults.string(forKey: "userInfo") {
                userInfo = info
            } else { userInfo = nil }
            
            let filename = getDocumentsDirectory().appendingPathComponent("userimage.png")
            if let image = UIImage(contentsOfFile: filename.path) {
                userImage = image
            } else { userImage = nil }
            
        }
    }
    
    func saveData() -> Bool {
        if userName == nil && userInfo == nil && userImage == nil {
            return false
        } else {
            userInitiatedQueue.sync {
                let defaults = UserDefaults.standard
                if let name = userName {
                    defaults.set(name, forKey: "userName")
                }
                
                if let info = userInfo {
                    defaults.set(info, forKey: "userInfo")
                }
                
                if let data = userImage?.pngData() {
                    let filename = getDocumentsDirectory().appendingPathComponent("userimage.png")
                    try? data.write(to: filename)
                }
            }
            return true
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}
