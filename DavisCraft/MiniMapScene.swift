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
    
    static var ratio_x: CGFloat = 1
    static var ratio_y: CGFloat = 1
    
    let realMapWidth: CGFloat = 2852    // Comes from runtime measuring - need to be improved
    let realMapHeight: CGFloat = 1693
    
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
                    elementColor = SKColor(red: 0.2, green: 0.5, blue: 0.2, alpha: 0.7)
                    break
                case "F":
                    elementColor = SKColor(red: 0.3, green: 0.3, blue: 0.1, alpha: 1.0)
                    break
                case "R":
                    elementColor = SKColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
                    break
                case "D":
                    elementColor = SKColor(red: 0.5, green: 0.5, blue: 0.3, alpha: 0.8)
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
            if i < height + 2 {
                x = 0.0
            }
        }   // for i
        
        // Initialize viewport
        MiniMapScene.ratio_x = MainViewController.miniMapWidth / realMapWidth
        MiniMapScene.ratio_y = MainViewController.miniMapHeight / realMapHeight
        updateViewPort( (realMapWidth - MainViewController.gameWidth / 2) * MiniMapScene.ratio_x, y_pos: -(realMapHeight - MainViewController.gameHeight / 2) * MiniMapScene.ratio_y)
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
    
    func updateViewPort(x_pos: CGFloat, y_pos: CGFloat) {
        let x_min = x_pos - (MainViewController.gameWidth * MiniMapScene.ratio_x / 2)
        let x_max = x_pos + (MainViewController.gameWidth * MiniMapScene.ratio_x / 2)
        let y_min = y_pos - (MainViewController.gameHeight * MiniMapScene.ratio_y / 2)
        let y_max = y_pos + (MainViewController.gameHeight * MiniMapScene.ratio_y / 2)
        if hasViewport {
            leftLine.removeFromParent()
            topLine.removeFromParent()
            rightLine.removeFromParent()
            bottomLine.removeFromParent()
        }
        let vpColor = SKColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        leftLine = SKSpriteNode(texture: nil, color: vpColor, size: CGSizeMake(1, y_max - y_min))
        topLine = SKSpriteNode(texture: nil, color: vpColor, size: CGSizeMake(x_max - x_min, 1))
        rightLine = SKSpriteNode(texture: nil, color: vpColor, size: CGSizeMake(1, y_max - y_min))
        bottomLine = SKSpriteNode(texture: nil, color: vpColor, size: CGSizeMake(x_max - x_min, 1))
        leftLine.position = CGPointMake(x_min, y_max - (MainViewController.gameHeight * MiniMapScene.ratio_y / 2))
        topLine.position = CGPointMake(x_min + (MainViewController.gameWidth * MiniMapScene.ratio_x / 2), y_max)
        rightLine.position = CGPointMake(x_max, y_max - (MainViewController.gameHeight * MiniMapScene.ratio_y / 2))
        bottomLine.position = CGPointMake(x_min + (MainViewController.gameWidth * MiniMapScene.ratio_x / 2), y_min)
        self.addChild(leftLine)
        self.addChild(topLine)
        self.addChild(rightLine)
        self.addChild(bottomLine)
    }
    
    func confineViewPort(inout point: CGPoint) {
        let leftB = MainViewController.gameWidth / 2 * MiniMapScene.ratio_x
        let topB = -MainViewController.gameHeight / 2 * MiniMapScene.ratio_y
        let rightB = MainViewController.miniMapWidth - leftB
        let bottomB = -MainViewController.miniMapHeight - topB
        if (point.x < leftB) {
            point.x = leftB
        }
        else if (point.x > rightB) {
            point.x = rightB
        }
        if (point.y < bottomB) {
            point.y = bottomB
        }
        else if (point.y > topB) {
            point.y = topB
        }
    }
    
    
}
