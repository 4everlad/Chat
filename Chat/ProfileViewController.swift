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
    
    
    @IBOutlet weak var editButton: UIButton!

    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBAction func chooseImageProfile(_ sender: UIButton) {
        print("Choose Image Profile")
        
        let alertController = UIAlertController(title: "Выберите действие", message: "", preferredStyle: .actionSheet)
        
        let setFromGallery = UIAlertAction(title: "Установить из галлереи", style: .default) { (action:UIAlertAction) in
            self.openPhotoLibraryButton(sender: self);
        }
        
        let takePhoto = UIAlertAction(title: "Сделать фото", style: .default) { (action:UIAlertAction) in
            self.openCameraButton(sender: self);
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        
        alertController.addAction(setFromGallery)
        alertController.addAction(takePhoto)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func openCameraButton(sender: AnyObject) {
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
    
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicked.image = image
        dismiss(animated:true, completion: nil)
    }

    
    @IBAction func saveButton(sender: AnyObject) {
        print ("save erroooooor")
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
//        let alert = UIAlertView(title: "Wow",
//                                message: "Your image has been saved to Photo Library!",
//                                delegate: nil,
//                                cancelButtonTitle: "Ok")
//        alert.show()
    }
    
//    convenience init() {
//        self.init(nibName:nil, bundle:nil)
//        print("editButton frame:\(editButton.layer.frame)")
//    }
    // init у View Controllerа не вызывается через Story Board

    override func viewDidLoad() {
        super.viewDidLoad()

        editButton.layer.borderColor = UIColor.black.cgColor
        editButton.layer.borderWidth = 1.0

        
        LoggingLifeCycle.logMethod()
        
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
        LoggingLifeCycle.logMethod()
        print("editButton frame:\(editButton.layer.frame)")
        // frame отличается потому что метод viewDidAppear вызывается после того как Auto Layout выполнит свою работу, в то время как viewDidLoad до. Auto Layout динамически рассчитатывает размер и позицию view во View Controller.
    }

    override func viewWillLayoutSubviews() {
//        LoggingLifeCycle.logMethod()
    }
    
    override func viewDidLayoutSubviews() {
//        LoggingLifeCycle.logMethod()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        LoggingLifeCycle.logMethod()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        LoggingLifeCycle.logMethod()
    }
    
    
}

