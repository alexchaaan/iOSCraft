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
        
        var skView: SKView!
        
        let fullWidth = self.view.bounds.size.width
        let fullHeight = self.view.bounds.size.height
        
        self.view.backgroundColor = UIColor.blackColor()
        /* Create and Add the skView as a subview of the UI (Charles) */
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            skView = SKView(frame: CGRectMake(fullWidth / 4, fullHeight / 20, fullWidth * 3 / 4, fullHeight))
            
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
            
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
        
        // SIDEPANEL
        // Add Minimap:
        let miniMap = MiniMapRender(frame:CGRectMake(5, fullHeight / 20 + 25, fullWidth / 4 - 6, fullHeight / 3 - 22), x_min: 2500, y_min: 1600, width: skView.frame.width, height: skView.frame.height)
        var sidePanel: UIView!
        sidePanel = UIView(frame: CGRectMake(0, 0, (fullWidth / 4) + 2, fullHeight))
        sidePanel.backgroundColor = UIColor(patternImage: UIImage(named: "Texture.png")!)
        sidePanel.addSubview(miniMap)
        self.view.addSubview(sidePanel)
        
        //        var goldValue: Int = 10000
        //        var lumberValue: Int = 10000
        
        //MENUPANEL by Javi
        let menuPanel = IconsRender()
        menuPanel.frame = CGRectMake(fullWidth / 4, 0, fullWidth, fullHeight / 20)
        menuPanel.drawMIcon(2, xDir: 50 , yDir: 2)
        menuPanel.drawMIcon(3, xDir: 200, yDir: 2)
        menuPanel.drawMIcon(4, xDir: 350, yDir: 2)
        menuPanel.drawGoldLabel(55, yDir: 5, width: 50, height: 10, text: "\(goldValue)", size: 8)
        menuPanel.drawWoodLabel(205, yDir: 5, width: 50, height: 10, text: "\(lumberValue)", size: 8)
        let menuB = UIImageView(image: UIImage(named: "MenuButton.png"))
        // let  buttonImg = UIImageView(image: UIImage(named: "MenuButton.png"))
        // let menuB = UIButton(frame: CGRect(x: sidePanel.bounds.size.width / 4 - 2, y: 1, width: buttonImg.bounds.size.width, height: buttonImg.bounds.size.height))
        // menuB.imageView!.image = buttonImg.image
        //           let humanMove = UIImageView(image: UIImage(CGImage: iDictionary![iNames[85]]!))
        //        self.addSubview(button)
        menuB.frame = CGRectMake(sidePanel.bounds.size.width / 4 - 2, 1, menuB.bounds.size.width, menuB.bounds.size.height)
        menuPanel.addSubview(menuB)
        //menuPanel.backgroundColor = UIColor(patternImage: UIImage(named: "Texture.png")!)
        menuPanel.backgroundColor = UIColor(red: 69/255, green: 47/255, blue: 21/255, alpha: 1.0)
        self.view.addSubview(menuPanel)
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
