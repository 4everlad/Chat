//
//  ProfileViewController.swift
//  Chat
//
//  Created by Dmitry Bakulin on 22.09.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var editButton: UIButton!
    

    @IBAction func chooseImageProfile(_ sender: UIButton) {
        print("Выбери изображение профиля")
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

