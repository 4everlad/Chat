//
//  OperationDataManager.swift
//  Chat
//
//  Created by Dmitry Bakulin on 22.10.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import Foundation

class OperationDataManager {
    var userName: String?
    var userInfo: String?
    var userImage: UIImage?
    
//    override var isExecuting: Bool {
//        get {
//            return Operation.is
//        }
//    }
    
    let queue = OperationQueue()
    
    func readData() {
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
        queue.addOperation {
            let defaults = UserDefaults.standard
            if let name = defaults.string(forKey: "userName") {
                self.userName = name
            } else { self.userName = nil }
            
            if let info = defaults.string(forKey: "userInfo") {
                self.userInfo = info
            } else { self.userInfo = nil }
            
            let filename = self.getDocumentsDirectory().appendingPathComponent("userimage.png")
            if let image = UIImage(contentsOfFile: filename.path) {
                self.userImage = image
            } else { self.userImage = nil }
        }
        queue.qualityOfService = .userInitiated
    }
    
    func saveData() {
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
        queue.addOperation {
            let defaults = UserDefaults.standard
            if let name = self.userName {
                defaults.set(name, forKey: "userName")
            }
            
            if let info = self.userInfo {
                defaults.set(info, forKey: "userInfo")
            }
            
            if let data = self.userImage?.pngData() {
                let filename = self.getDocumentsDirectory().appendingPathComponent("userimage.png")
                try? data.write(to: filename)
            }
        }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
}

