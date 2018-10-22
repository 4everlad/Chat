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
    
    let queue = OperationQueue()
    
    func readUserName() -> String? {
        let defaults = UserDefaults.standard
        if let name = defaults.string(forKey: "userName") {
            return name
        } else {
            print("Name is not set")
            return nil
        }
    }
    
    func readUserInfo() -> String? {
        let defaults = UserDefaults.standard
        if let name = defaults.string(forKey: "userInfo") {
            return name
        } else {
            print("Name is not set")
            return nil
        }
    }
    
    func readData() {
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
        queue.addOperation {
            self.userName = self.readUserName()
            self.userInfo = self.readUserInfo()
            self.userImage = self.readImage()
        }
        queue.qualityOfService = .userInitiated
    }
    
    func saveData() {
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
        queue.addOperation {
            self.saveUserName()
            self.saveUserInfo()
            self.saveImage()
        }
    }
    
    func saveUserName() {
        if let name = userName {
            let defaults = UserDefaults.standard
            defaults.set(name, forKey: "userName")
        }
    }
    
    func saveUserInfo() {
        if let info = userInfo {
            let defaults = UserDefaults.standard
            defaults.set(info, forKey: "userInfo")
        }
    }
    
    
    func readImage() -> UIImage? {
        let filename = getDocumentsDirectory().appendingPathComponent("userimage.png")
        if let image = UIImage(contentsOfFile: filename.path) {
            return image
        } else {
            print("no image file at that directory")
            return nil
        }
    }
    
    func saveImage() {
        //        let image = userImage
        if let data = userImage?.pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent("userimage.png")
            try? data.write(to: filename)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

