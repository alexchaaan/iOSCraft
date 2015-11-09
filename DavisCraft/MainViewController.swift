//
//  MainViewController.swift
//  DavisCraft
//
//  Created by Andrew Tran on 11/1/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fullWidth = self.view.bounds.size.width
        let fullHeight = self.view.bounds.size.height
        
        self.view.backgroundColor = UIColor.blackColor()
        /* Create and Add the skView as a subview of the UI (Charles) */
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = SKView(frame: CGRectMake(fullWidth / 4, fullHeight / 20, fullWidth * 3 / 4, fullHeight))
            
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .Fill
            
            skView.presentScene(scene)
            self.view.addSubview(skView)
        }
        else {
            print("GameScene initialization failed.")
        }
        
        
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
