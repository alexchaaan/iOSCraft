//
//  MiniMap.swift
//  DavisCraft
//
//  Created by Charles_Fox_W on 11/11/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit

class MiniMapScene: SKScene {
    
    var leftLine: SKSpriteNode!
    var topLine: SKSpriteNode!
    var rightLine: SKSpriteNode!
    var bottomLine: SKSpriteNode!
    var hasViewport: Bool = false
    
    override func didMoveToView(view: SKView) {
        anchorPoint = CGPointMake(0, 1)
        // Read the map data from file
        let (map,width,height) = readMap()
        
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        let step: CGFloat = 1.85
        // Draw mini-map
        for i in 3 ..< (height + 3){
            var mapLine = Array(map[i].characters)
            for j in 1..<width + 1{
                let location = CGPointMake(x, -y)
                var elementColor: SKColor!
                switch mapLine[j] {
                case "G":
                    elementColor = SKColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 0.7)
                    break
                case "F":
                    elementColor = SKColor(red: 0.3, green: 0.3, blue: 0.1, alpha: 1.0)
                    break
                case "R":
                    elementColor = SKColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
                    break
                case "D":
                    elementColor = SKColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
                    break
                case "W":
                    elementColor = SKColor(red: 0.6, green: 0.6, blue: 0.1, alpha: 1.0)
                    break
                case "w":
                    elementColor = SKColor(red: 0.8, green: 0.8, blue: 0.1, alpha: 1.0)
                    break
                case " ":
                    elementColor = SKColor(red: 0.2, green: 0.6, blue: 0.8, alpha: 1.0)
                    break
                default:
                    elementColor = SKColor(red: 0.3, green: 0.8, blue: 0.3, alpha: 0.8)
                    break
                }
                
                let node = SKSpriteNode(texture: nil, color: elementColor, size: CGSizeMake(step, step))
                node.position = location
                self.addChild(node)
                x += step
            }   // for j
            y += step
            x = 0.0
        }   // for i
        
        drawViewPort(100, y_pos: -100)
        hasViewport = true
    }
    
    func readMap() -> (Array<String>, Int, Int){
        //have button to give map filename
        let fileName = "2player.map"
        let mapContent = FileManager.returnDatFileContents(fileName, subdirectory: "map")
        let mapInfo = mapContent!.componentsSeparatedByString("\n")
        //let mapName = mapInfo[0]
        let mapDimension = mapInfo[1].componentsSeparatedByString(" ")
        let mapWidth = Int(mapDimension[0])!
        let mapHeight = Int(mapDimension[1])!
        return (mapInfo, mapWidth, mapHeight)
    }
    
    func drawViewPort(x_pos: CGFloat, y_pos: CGFloat) {
        let ratio_x = MainViewController.miniMapWidth / 3000
        let ratio_y = MainViewController.miniMapHeight / 2000
        let x_min = x_pos - (MainViewController.gameWidth * ratio_x / 2)
        let x_max = x_pos + (MainViewController.gameWidth * ratio_x / 2)
        let y_min = y_pos - (MainViewController.gameHeight * ratio_y / 2)
        let y_max = y_pos + (MainViewController.gameHeight * ratio_y / 2)
        if hasViewport {
            leftLine.removeFromParent()
            topLine.removeFromParent()
            rightLine.removeFromParent()
            bottomLine.removeFromParent()
        }
        leftLine = SKSpriteNode(texture: nil, color: SKColor.whiteColor(), size: CGSizeMake(1, y_max - y_min))
        topLine = SKSpriteNode(texture: nil, color: SKColor.whiteColor(), size: CGSizeMake(x_max - x_min, 1))
        rightLine = SKSpriteNode(texture: nil, color: SKColor.whiteColor(), size: CGSizeMake(1, y_max - y_min))
        bottomLine = SKSpriteNode(texture: nil, color: SKColor.whiteColor(), size: CGSizeMake(x_max - x_min, 1))
        leftLine.position = CGPointMake(x_min, y_max - (MainViewController.gameHeight * ratio_y / 2))
        topLine.position = CGPointMake(x_min + (MainViewController.gameWidth * ratio_x / 2), y_max)
        rightLine.position = CGPointMake(x_max, y_max - (MainViewController.gameHeight * ratio_y / 2))
        bottomLine.position = CGPointMake(x_min + (MainViewController.gameWidth * ratio_x / 2), y_min)
        self.addChild(leftLine)
        self.addChild(topLine)
        self.addChild(rightLine)
        self.addChild(bottomLine)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first!.locationInNode(self)
        
        drawViewPort(location.x, y_pos: location.y)
        
    }
    
}
