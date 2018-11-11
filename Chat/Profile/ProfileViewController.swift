//
//  ProfileViewController.swift
//  Chat
//
//  Created by Dmitry Bakulin on 22.09.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextViewDelegate {
    
    let manager = StorageManager()
    
 //   var log = LoggingLifeCycle()
    
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    


//    let gcd = GCDDataManager()
//    let operation = OperationDataManager()
    
    @IBOutlet weak var editButton: UIButton!

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet var chooseImageButton: UIButton!
    
    @IBOutlet var userNameTextField: UITextField!
    
    @IBOutlet var userInfoTextView: UITextView!
    
    @IBOutlet var saveButton: UIButton!
    
//    @IBOutlet var operationButton: UIButton!
    
    @IBOutlet var savingActivityIndicator: UIActivityIndicatorView!
    
    
    @IBAction func editProfile(_ sender: UIButton) {
        editButton.isEnabled = false
        editButton.isHidden = true
        
        chooseImageButton.isHidden = false
        
        saveButton.isHidden = false
        saveButton.isEnabled = false
//        operationButton.isHidden = false
//        operationButton.isEnabled = false
        
        userNameTextField.isUserInteractionEnabled = true
        userNameTextField.font = UIFont(name: "System", size: 14)
        userNameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        
        editButton.isHidden = true
        
        userNameTextField.isUserInteractionEnabled = true
        userInfoTextView.isUserInteractionEnabled = true
        
    }
    
    @IBAction func saveProfile(_ sender: Any) {
        
        let data = User()
        
        savingActivityIndicator.isHidden = false
        savingActivityIndicator.startAnimating()
        saveButton.isEnabled = false
        
    
        
//        operationButton.isEnabled = false
        
        data.userName = userNameTextField.text
        data.userInfo = userInfoTextView.text
        data.userImage = userImage.image
        
        manager.saveData(data: data)
        
//        manager.insertData(data: data)
        
//        if gcd.userName == userNameTextField.text {
//            gcd.userName = nil
//        } else { gcd.userName = userNameTextField.text }
//
//        if gcd.userInfo == userInfoTextView.text {
//            gcd.userInfo = nil
//        } else { gcd.userInfo = userInfoTextView.text }
//
//        if gcd.userImage == userImage.image {
//            gcd.userImage = nil
//        } else { gcd.userImage = userImage.image }
//
//        let savingResult = gcd.saveData()
//
//        if savingResult {
//            let alertController = UIAlertController(title: "Данные сохранены",
//                                                    message: nil,
//                                                    preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alertController, animated: true)
//        } else {
//            let alertController = UIAlertController(title: "Ошибка",
//                                                    message: "Не удалось сохранить данные",
//                                                    preferredStyle: .alert)
//
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//
//            alertController.addAction(UIAlertAction(title: "Повторить", style: .default) { (action:UIAlertAction) in self.saveWithGCD((Any).self) });
//
//                self.present(alertController, animated: true)
//            }
//
//        gcd.readData()
//
//        userNameTextField.text = gcd.userName
//        userInfoTextView.text = gcd.userInfo
//        userImage.image = gcd.userImage
        
        backToViewMode()
        
    }
    
//    @IBAction func saveWithOperation(_ sender: Any) {
//        savingActivityIndicator.isHidden = false
//        savingActivityIndicator.startAnimating()
//        gcdButton.isEnabled = false
//        operationButton.isEnabled = false
//
//        if operation.userName == userNameTextField.text {
//            operation.userName = nil
//        } else { operation.userName = userNameTextField.text }
//
//        if operation.userInfo == userInfoTextView.text {
//            operation.userInfo = nil
//        } else { operation.userInfo = userInfoTextView.text }
//
//        if operation.userImage == userImage.image {
//            operation.userImage = nil
//        } else { operation.userImage = userImage.image }
//
//        operation.saveData()
//        operation.readData()
//
//        userNameTextField.text = operation.userName
//        userInfoTextView.text = operation.userInfo
//        userImage.image = operation.userImage
//
////        savingAlert(isSucceeded: true, isGCD: true)
//        backToViewMode()
//    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        saveButton.isEnabled = true
//        operationButton.isEnabled = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        saveButton.isEnabled = true
//        operationButton.isEnabled = true
    }
    
    
    func backToViewMode() {
        
        savingActivityIndicator.stopAnimating()
        chooseImageButton.isHidden = true
        
//        userNameTextField.isUserInteractionEnabled = false
        userNameTextField.font = UIFont.boldSystemFont(ofSize: 27.0)
        userNameTextField.borderStyle = UITextField.BorderStyle.none
        userNameTextField.isUserInteractionEnabled = false
        userInfoTextView.isUserInteractionEnabled = false
        userInfoTextView.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)
//        userInfoTextView.font = UIFont.thinSystemFont(ofSize: 17.0)
        
        editButton.isEnabled = true
        editButton.isHidden = false
        
        saveButton.isHidden = true
//        operationButton.isHidden = true
        
        savingActivityIndicator.isHidden = true
        
    }
    
//    func savingAlert(isSucceeded: Bool, isGCD: Bool) {
//
//
//    }
    
    
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
    
    @IBAction func closeProfileButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        
//        let context = appDelegate.persistentContainer.viewContext
        
//        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
//        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        
        userNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        userInfoTextView.delegate = self

        editButton.layer.borderColor = UIColor.black.cgColor
        editButton.layer.borderWidth = 1.0
        chooseImageButton.isHidden = true
        
        saveButton.isHidden = true
//        operationButton.isHidden = true

        userNameTextField.isUserInteractionEnabled = false
        userInfoTextView.isUserInteractionEnabled = false
        
        savingActivityIndicator.isHidden = true
        
        
        
        let dataProfile = manager.readData()
        
        
        if let image = dataProfile.userImage {
            userImage.image = image
        } else {
            userImage.image = #imageLiteral(resourceName: "UserPlaceholder")
        }
//
        if let name = dataProfile.userName {
            userNameTextField.text = name
        } else { userNameTextField.text = "Your Name" }
//
        if let info = dataProfile.userInfo {
            userInfoTextView.text = info
        } else { userInfoTextView.text = "Your Profile Information" }
// //       log.printMethod()
        
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
//        log.printMethod()
        print("editButton frame:\(editButton.layer.frame)")
        // frame отличается потому что метод viewDidAppear вызывается после того как Auto Layout выполнит свою работу, в то время как viewDidLoad до. Auto Layout динамически рассчитатывает размер и позицию view во View Controller.
    }

    override func viewWillLayoutSubviews() {
 //       log.printMethod()
    }
    
    override func viewDidLayoutSubviews() {
 //       log.printMethod()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        log.printMethod()
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
