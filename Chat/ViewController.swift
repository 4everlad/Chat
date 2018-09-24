//
//  ViewController.swift
//  Chat
//
//  Created by Dmitry Bakulin on 22.09.2018.
//  Copyright © 2018 Dmitry Bakulin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    func logMethod(methodName: String = #function) {
        print("ViewController method: <\(methodName)>")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        logMethod()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        logMethod()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logMethod()
    }

    override func viewWillLayoutSubviews() {
        logMethod()
    }
    
    override func viewDidLayoutSubviews() {
        logMethod()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logMethod()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logMethod()
    }
    
    
}

