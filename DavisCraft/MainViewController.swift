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
        
        
        var selected: Bool?
        
        var assetType = "barracks"
        
        let fullWidth = self.view.bounds.size.width
        let fullHeight = self.view.bounds.size.height
        let scene = GameScene(fileNamed: "GameScene")
        self.view.backgroundColor = UIColor.blackColor()
        /* Create and Add the skView as a subview of the UI (Charles) */
        if scene != nil {// Configure the view.
            skView = SKView(frame: CGRectMake(fullWidth / 4, fullHeight / 20, fullWidth * 3 / 4, fullHeight))
            
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene!.scaleMode = .Fill
            
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
        
        
        //MENUPANEL by Javi
        let menuPanel = IconsRender()
        menuPanel.frame = CGRectMake(0, 0, fullWidth, fullHeight / 20)
        menuPanel.drawMIcon(2, xDir: 180 , yDir: 2)
        menuPanel.drawMIcon(3, xDir: 330, yDir: 2)
        menuPanel.drawMIcon(4, xDir: 480, yDir: 2)
        menuPanel.drawGoldLabel(183, yDir: 5, width: 50, height: 10, text: "\(goldValue)", size: 8)
        menuPanel.drawWoodLabel(333, yDir: 5, width: 50, height: 10, text: "\(lumberValue)", size: 8)
        
        let menuImg = UIImage(named: "MenuButton.png")
        let menuB = UIImageView(image: menuImg)
        let menuBut = UIButton()
        menuBut.setImage(menuImg, forState: UIControlState.Normal)
        
        menuBut.frame = CGRectMake(sidePanel.bounds.size.width / 4 - 2, 1, menuB.bounds.size.width, menuB.bounds.size.height)
        menuPanel.addSubview(menuBut)
        //menuPanel.backgroundColor = UIColor(patternImage: UIImage(named: "Texture.png")!)
        menuPanel.backgroundColor = UIColor(patternImage: UIImage(named: "Texture.png")!)
        self.view.addSubview(menuPanel)
        
        let miniHeight = miniMap.bounds.size.height
        let miniWidth = miniMap.bounds.size.width
        
        let descPanel = DescLabelRender()
        descPanel.frame = CGRectMake(1, miniHeight * 1.5, miniWidth, miniHeight/1.1)
        
        self.view.addSubview(descPanel)
        scene?.setDescPanelRender(descPanel)
        
        
        let actionPanel = ActionPanelRender()
        actionPanel.frame = CGRectMake(1, (miniHeight * 2.5), miniWidth/0.95, miniHeight / 0.8)
        
        self.view.addSubview(actionPanel)
        scene?.setActionPanelRender(actionPanel)
        
        view.addSubview(actionPanel)
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
