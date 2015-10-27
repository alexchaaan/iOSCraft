//
//  NetworkOptions.swift
//  ECS160Game
//
//  Created by Hidekazu Shidara on 10/4/15.
//  Copyright © 2015 Hidekazu Shidara. All rights reserved.
//

import UIKit

class NetworkOptions: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
