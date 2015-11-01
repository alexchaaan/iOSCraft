//
//  SinglePlayerGame.swift
//  ECS160Game
//
//  Created by Hidekazu Shidara on 10/4/15.
//  Copyright © 2015 Hidekazu Shidara. All rights reserved.
//

import UIKit
import SpriteKit

class SinglePlayerGame: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectTouchUpInside(sender: AnyObject) {
        performSegueWithIdentifier("select", sender: nil)
        
    }
    
}
