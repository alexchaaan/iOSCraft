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
    
    // Charles - Move the handlers out here:
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        print("BEGIN")
        GameScene.lastTouchPosition = touches.first!.locationInNode(MainViewController.gameScene)
        if isInside(GameScene.lastTouchPosition, x_max: MainViewController.gameWidth, y_max: MainViewController.gameHeight, refl: true) {
            if (GameScene.buildMode == true) {
                GameScene.isMoving = true
                GameScene.newBuilding.position = MainViewController.gameScene.convertPoint(GameScene.lastTouchPosition, toNode: GameScene.map)
                Building.positionOnTile(GameScene.newBuilding)
                Building.setNewBuildingTint(GameScene.newBuilding)
            }
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let newTouchPosition = touches.first!.locationInNode(MainViewController.gameScene)
        //if isInside(newTouchPosition, x_max: MainViewController.gameWidth, y_max: MainViewController.gameHeight, refl: true) {
            if (GameScene.buildMode == false) {
                let touchOffsetVector = CGPointMake(newTouchPosition.x - GameScene.lastTouchPosition.x, (newTouchPosition.y - GameScene.lastTouchPosition.y) )
                let mapCameraPositionInScene = MainViewController.gameScene.convertPoint(GameScene.map.camera.position, toNode: MainViewController.gameScene)
                let newCameraPosition = CGPointMake(mapCameraPositionInScene.x - touchOffsetVector.x, mapCameraPositionInScene.y - touchOffsetVector.y)
                MainViewController.gameScene.constrainCameraPosition(newCameraPosition)
                var miniMapPosition = CGPointMake((newCameraPosition.x + MainViewController.gameWidth / 2) * MiniMapScene.ratio_x, (newCameraPosition.y - MainViewController.gameHeight / 2) * MiniMapScene.ratio_y)
                MainViewController.miniMapScene.confineViewPort(&miniMapPosition)
                MainViewController.miniMapScene.updateViewPort(miniMapPosition.x, y_pos: miniMapPosition.y)
                GameScene.lastTouchPosition = newTouchPosition
            }
            else {
                GameScene.didMove = true
                GameScene.lastTouchPosition = newTouchPosition
                Building.setNewBuildingTint(GameScene.newBuilding)
            }
        //}
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var locMinimap = touches.first!.locationInNode(MainViewController.miniMapScene)
        let newEndPosition = touches.first!.locationInNode(MainViewController.gameScene)
        if isInside(locMinimap, x_max: MainViewController.miniMapWidth, y_max: MainViewController.miniMapHeight, refl: true) {
            // Constrain the position of viewport:
            MainViewController.miniMapScene.confineViewPort(&locMinimap)
            MainViewController.miniMapScene.updateViewPort(locMinimap.x, y_pos: locMinimap.y)
            let gamePosition = CGPointMake(locMinimap.x / MiniMapScene.ratio_x - (MainViewController.gameWidth / 2), locMinimap.y / MiniMapScene.ratio_y + (MainViewController.gameHeight / 2))
            MainViewController.gameScene.constrainCameraPosition(gamePosition)
            print("touched: x = \(locMinimap.x), y = \(locMinimap.y)")
        }
        else if isInside(newEndPosition, x_max: MainViewController.gameWidth, y_max: MainViewController.gameHeight, refl: true) {
            print("ENDED")
            if (GameScene.newBuilding != nil && GameScene.newBuilding.physicsBody?.allContactedBodies().count == 0) {
                Building.setNewBuildingTint(GameScene.newBuilding)
                //gameScene.placeNewBuilding()
            }
            GameScene.isMoving = false
        }
    }
    
    func isInside(point: CGPoint, x_max: CGFloat, y_max: CGFloat, refl: Bool) -> Bool {
        if refl {
            return (point.x >= 0 && point.x <= x_max && -point.y >= 0 && -point.y <= y_max)
        }
        else {
            return (point.x >= 0 && point.x <= x_max && point.y >= 0 && point.y <= y_max)
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
