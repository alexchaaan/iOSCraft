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
    
    var realminiMapWidth: CGFloat = 0
    var realminiMapHeight: CGFloat = 0
    var realRatio_x: CGFloat = 1
    var realRatio_y: CGFloat = 1
    let realMapWidth: CGFloat = 2852    // Comes from runtime measuring - need to be improved
    let realMapHeight: CGFloat = 1693
    var errorRatio_x: CGFloat = 1
    var errorRatio_y: CGFloat = 1
    
    var unitCount: Int = 0
    var unitSet: [SKSpriteNode] = []
    
    override func didMoveToView(view: SKView) {
        anchorPoint = CGPointMake(0, 1)
        // Read the map data from file
        let (map,width,height) = readMap()
        
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        let step_x: CGFloat = 1.7
        let step_y: CGFloat = 1.6
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
                
                let node = SKSpriteNode(texture: nil, color: elementColor, size: CGSizeMake(step_x, step_y))
                node.position = location
                self.addChild(node)
                x += step_x
            }   // for j
            y += step_y
            if i < height + 2 {
                x = 0.0
            }
        }   // for i
        //MainViewController.miniMapWidth = x
        //MainViewController.miniMapHeight = y
        realminiMapWidth = x
        realminiMapHeight = y
        realRatio_x = realminiMapWidth / realMapWidth
        realRatio_y = realminiMapHeight / realMapHeight
        errorRatio_x = realMapWidth / 3072
        errorRatio_y = realMapHeight / 2048
        print("realminimap: x = \(realminiMapWidth), y = \(realminiMapHeight)")
        // Initialize viewport
        MiniMapScene.ratio_x = MainViewController.miniMapWidth / realMapWidth
        MiniMapScene.ratio_y = MainViewController.miniMapHeight / realMapHeight
        updateViewPort( (realMapWidth - MainViewController.gameWidth / 2) * MiniMapScene.ratio_x, y_pos: -(realMapHeight - MainViewController.gameHeight / 2) * MiniMapScene.ratio_y)
        hasViewport = true
        
        for index in 73..<map.endIndex - 2 {
            let item = map[index].componentsSeparatedByString(" ")
            let placement = CGPointMake(32 * CGFloat(Int(item[2])!) * errorRatio_x * MiniMapScene.ratio_x, -32 * CGFloat(Int(item[3])!) * errorRatio_y * MiniMapScene.ratio_y)
            drawAsset(placement, sprite: item[0])
        }
        
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
    
    func drawAsset(var placement: CGPoint, sprite: String){
        var assetColor: SKColor!
        var assetImage: UIImage!
        var index: Int = 0
        var isUnit: Bool = false
        switch(sprite){
            case "GoldMine":
                assetColor = SKColor.greenColor()
                assetImage = UIImage(named: "data/png/GoldMine.png")!
                index = 2
                break
            case "Peasant":
                assetColor = SKColor.blueColor()
                assetImage = UIImage(named: "data/png/Peasant.png")!
                index = 172
                isUnit = true
                break
            case "TownHall":
                assetColor = SKColor.blueColor()
                assetImage = UIImage(named: "data/png/TownHall.png")!
                index = 4
                break
            default:
                assetColor = SKColor.clearColor()
                assetImage = UIImage(named: "data/png/Texture.png")!
                index = 1
                break
        }
        let width = assetImage.size.width
        let height = assetImage.size.height
        let fileName = sprite + ".dat"
        let content = FileManager.returnDatFileContents(fileName)
        let contentArray = content!.componentsSeparatedByString("\n")
        let numberOfTiles = Int(contentArray[1]);
        placement.y -= (height - (CGFloat(index)*(height/CGFloat(numberOfTiles!)))) * realRatio_y
        let assetWidth = width * realRatio_x
        let assetHeight = height / CGFloat(numberOfTiles!) * realRatio_y
        
        let spriteNode = SKSpriteNode(texture: nil, color: assetColor, size: CGSizeMake(assetWidth, assetHeight))
        spriteNode.position = CGPointMake(placement.x + assetWidth / 2, placement.y - assetHeight / 2)
        if isUnit {
            unitSet.append(spriteNode)
            unitCount++
        }
        self.addChild(spriteNode)
    }
    
    func reflectBuildingToMini(node: SKNode) {
        let placement = CGPointMake(node.position.x * MiniMapScene.ratio_x * errorRatio_x, node.position.y * MiniMapScene.ratio_y * errorRatio_y)
        var currSprite: String!
        switch (node) {
        case is TownHall:
            currSprite = "TownHall"
        default:
            break
        
        }
        self.drawAsset(placement, sprite: currSprite)
    }
    
    func reflectMovingSPToMini(selectedSprite: SKNode, touchedSprite: SKSpriteNode, floatDuration: NSTimeInterval) {
        let location = CGPointMake(touchedSprite.position.x * MiniMapScene.ratio_x * errorRatio_x, touchedSprite.position.y * MiniMapScene.ratio_y * errorRatio_y)
        let moveAction = SKAction.moveTo(location, duration: floatDuration)
        let movableSprite = selectedSprite as! Unit
        let spriteInMiniMap = unitSet[movableSprite.appearingOrder]
        spriteInMiniMap.runAction(moveAction)
    }
}
