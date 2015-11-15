//
//  MainViewController.swift
//  DavisCraft
//
//  Created by Andrew Tran on 11/1/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit
let menuPanel = IconsRender()
class MainViewController: UIViewController {
    
    static var miniMapWidth: CGFloat! = 0
    static var miniMapHeight: CGFloat! = 0
    static var gameWidth: CGFloat! = 0
    static var gameHeight: CGFloat! = 0
    
    var gameView: SKView!
    var miniMapView: SKView!
    var gameScene: GameScene!
    var miniMapScene: MiniMapScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var selected: Bool?
        
        var assetType = "barracks"
        
        let fullWidth = self.view.bounds.size.width
        let fullHeight = self.view.bounds.size.height
        
        // SIDEPANEL
        // Add Minimap:
        var sidePanel: UIView!
        sidePanel = UIView(frame: CGRectMake(0, 0, (fullWidth / 4) + 2, fullHeight))
        sidePanel.backgroundColor = UIColor(patternImage: UIImage(named: "Texture.png")!)
        // Add GameScene:
        gameScene = GameScene(fileNamed: "GameScene")
        self.view.backgroundColor = UIColor.blackColor()
        /* Create and Add the skView as a subview of the UI (Charles) */
        if gameScene != nil {// Configure the view.
            MainViewController.gameWidth = fullWidth * 3 / 4
            MainViewController.gameHeight = fullHeight * 19 / 20
            gameView = SKView(frame: CGRectMake(fullWidth / 4, fullHeight / 20, fullWidth * 3 / 4, fullHeight * 19 / 20))
            print("battle field width = \(MainViewController.gameWidth), height = \(MainViewController.gameHeight)")
            
            gameView.showsFPS = true
            gameView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            gameView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            gameScene!.scaleMode = .Fill
            
            gameView.presentScene(gameScene)
            self.view.addSubview(gameView)
        }
        else {
            print("GameScene initialization failed.")
        }
        
        
        // Create miniMapScene - Charles
        miniMapScene = MiniMapScene(size: CGSizeMake(fullWidth / 4 - 7, fullHeight / 3 - 22))
        MainViewController.miniMapWidth = miniMapScene.size.width
        MainViewController.miniMapHeight = miniMapScene.size.height
        
        miniMapView = SKView(frame:CGRectMake(5, fullHeight / 20 + 25, MainViewController.miniMapWidth, MainViewController.miniMapHeight))
        miniMapView.showsFPS = false
        miniMapView.showsNodeCount = false
        miniMapScene.scaleMode = .Fill
        miniMapView.presentScene(miniMapScene)
        sidePanel.addSubview(miniMapView)
        
        self.view.addSubview(sidePanel)
        
        //MENUPANEL by Javi
//        let menuPanel = IconsRender()
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
        
        let descPanel = DescLabelRender()
        descPanel.frame = CGRectMake(1, MainViewController.miniMapHeight * 1.5, MainViewController.miniMapWidth, MainViewController.miniMapHeight/1.1)
        
        self.view.addSubview(descPanel)
        gameScene?.setDescPanelRender(descPanel)
        
        
        let actionPanel = ActionPanelRender()
        actionPanel.frame = CGRectMake(1, (MainViewController.miniMapHeight * 2.5), MainViewController.miniMapWidth/0.95, MainViewController.miniMapHeight / 0.8)
        
        self.view.addSubview(actionPanel)
        gameScene?.setActionPanelRender(actionPanel)
        
        view.addSubview(actionPanel)
        
    }
    
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let locMinimap = touches.first!.locationInNode(miniMapScene)
        if (locMinimap.x >= 0 && locMinimap.x <= MainViewController.miniMapWidth && -locMinimap.y >= 0 && -locMinimap.y <= MainViewController.miniMapHeight) {
            print("get MainView: x = \(locMinimap.x), y = \(locMinimap.y)")
            miniMapScene.updateViewPort(locMinimap.x, y_pos: locMinimap.y)
            let gamePosition = CGPointMake(locMinimap.x / MiniMapScene.ratio_x - (MainViewController.gameWidth / 2), locMinimap.y / MiniMapScene.ratio_y + (MainViewController.gameHeight / 2))
            gameScene.constrainCameraPosition(gamePosition)
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
