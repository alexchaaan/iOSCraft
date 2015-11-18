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
    static var gameScene: GameScene!
    static var miniMapScene: MiniMapScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let goldValue: Int = 10000
        let lumberValue: Int = 10000
        
        let fullWidth = self.view.bounds.size.width
        let fullHeight = self.view.bounds.size.height
        
        MainViewController.gameWidth = fullWidth * 3 / 4
        MainViewController.gameHeight = fullHeight * 19 / 20
        MainViewController.miniMapWidth = fullWidth / 4 - 7
        MainViewController.miniMapHeight = fullHeight / 3 - 22
        
        // SIDEPANEL
        // Add Minimap:
        var sidePanel: UIView!
        sidePanel = UIView(frame: CGRectMake(0, 0, (fullWidth / 4) + 2, fullHeight))
        sidePanel.backgroundColor = UIColor(patternImage: UIImage(named: "Texture.png")!)
        
        // Create miniMapScene - Charles
        MainViewController.miniMapScene = MiniMapScene(size: CGSizeMake(MainViewController.miniMapWidth, MainViewController.miniMapHeight))
        
        print("minimapView Width = \(MainViewController.miniMapWidth), Height = \(MainViewController.miniMapHeight)")
        miniMapView = SKView(frame:CGRectMake(5, fullHeight / 20 + 25, MainViewController.miniMapWidth, MainViewController.miniMapHeight))
        miniMapView.showsFPS = false
        miniMapView.showsNodeCount = false
        MainViewController.miniMapScene.scaleMode = .Fill
        miniMapView.presentScene(MainViewController.miniMapScene)
        sidePanel.addSubview(miniMapView)
        
        // Add GameScene:
        MainViewController.gameScene = GameScene(fileNamed: "GameScene")
        self.view.backgroundColor = UIColor.blackColor()
        /* Create and Add the skView as a subview of the UI (Charles) */
        if MainViewController.gameScene != nil {// Configure the view.
            gameView = SKView(frame: CGRectMake(fullWidth / 4, fullHeight / 20, fullWidth * 3 / 4, fullHeight * 19 / 20))
            print("battle field width = \(MainViewController.gameWidth), height = \(MainViewController.gameHeight)")
            
            gameView.showsFPS = true
            gameView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            gameView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            MainViewController.gameScene!.scaleMode = .Fill
            
            gameView.presentScene(MainViewController.gameScene)
            self.view.addSubview(gameView)
        }
        else {
            print("GameScene initialization failed.")
        }
        
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
        MainViewController.gameScene?.setDescPanelRender(descPanel)
        
        
        let actionPanel = ActionPanelRender()
        actionPanel.frame = CGRectMake(1, (MainViewController.miniMapHeight * 2.5), MainViewController.miniMapWidth/0.95, MainViewController.miniMapHeight / 0.8)
        
        self.view.addSubview(actionPanel)
        MainViewController.gameScene?.setActionPanelRender(actionPanel)
        
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
