//
//  GameViewController.swift
//  ECS160Game
//
//  Created by Hidekazu Shidara on 10/3/15.
//  Copyright (c) 2015 Hidekazu Shidara. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var scene : GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Sound.playBackgroundMusic("menu.mid")
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.multipleTouchEnabled = false
        
        /* Set the scale mode to scale to fit the window */
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
