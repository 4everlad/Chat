//
//  ProfileViewController.swift
//  Chat
//
//  Created by Dmitry Bakulin on 22.09.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    var log = LoggingLifeCycle()

    
    @IBOutlet weak var editButton: UIButton!

    @IBOutlet weak var userImage: UIImageView!
    
    @IBAction func chooseImageProfile(_ sender: UIButton) {
        print("Choose Image Profile")
        
        let alertController = UIAlertController(title: "Выберите действие", message: "", preferredStyle: .actionSheet)
        
        let setFromPhotoLibrary = UIAlertAction(title: "Установить из галлереи", style: .default) { (action:UIAlertAction) in
            self.setFromPhotoLibrary(sender: self);
        }
        
        let takePhoto = UIAlertAction(title: "Сделать фото", style: .default) { (action:UIAlertAction) in
            self.takePhoto(sender: self);
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        
        alertController.addAction(setFromPhotoLibrary)
        alertController.addAction(takePhoto)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func takePhoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("camera is available")
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else { print("camera is not available") }
    }
    
    @IBAction func setFromPhotoLibrary(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage
        userImage.image = image
        dismiss(animated:true, completion: nil)
    }


    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        if let button = editButton {
            print("coder editButton frame:\(button.layer.frame)")
        } else {
            print ("found nil while unwrapping")
        }
        
        // на момент вызова init, кнопка еще не создана
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        editButton.layer.borderColor = UIColor.black.cgColor
        editButton.layer.borderWidth = 1.0

        
        log.printMethod()
        
        print("editButton frame:\(editButton.layer.frame)")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
//        LoggingLifeCycle.logMethod()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        LoggingLifeCycle.logMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        log.printMethod()
        print("editButton frame:\(editButton.layer.frame)")
        // frame отличается потому что метод viewDidAppear вызывается после того как Auto Layout выполнит свою работу, в то время как viewDidLoad до. Auto Layout динамически рассчитатывает размер и позицию view во View Controller.
    }

    override func viewWillLayoutSubviews() {
        log.printMethod()
    }
    
    override func viewDidLayoutSubviews() {
        log.printMethod()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        log.printMethod()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        LoggingLifeCycle.logMethod()
    }
    
    
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
