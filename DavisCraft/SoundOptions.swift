//
//  SoundOptions.swift
//  ECS160Game
//
//  Created by Hidekazu Shidara on 10/4/15.
//  Copyright © 2015 Hidekazu Shidara. All rights reserved.
//

import UIKit

class SoundOptions: UIViewController,UITextFieldDelegate {

    var fxVolume = String()
    var musicVolume = String()
    
    @IBOutlet weak var fxVolumeTextField: UITextField!
    @IBOutlet weak var musicVolumeTextField: UITextField!
    
    @IBAction func didPressOK(sender: UIButton) {
        self.fxVolume = fxVolumeTextField.text!
        self.musicVolume = musicVolumeTextField.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fxVolume = "100"
        self.musicVolume = "50"
        
        self.fxVolumeTextField.text = fxVolume
        self.musicVolumeTextField.text = musicVolume
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
