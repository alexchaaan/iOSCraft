//
//  MapRender.swift
//  DavisCraft
//
//  Created by Andrew Tran on 10/16/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit
import SpriteKit

class MapRender/*: UIView*/ {
    //each map tile is 32x32
    func readTerrain() -> (Dictionary <String, CGImage>?, Array<String>) {
        //read in the tiles for the map
        let fileName = "Terrain.dat"
        let terrainDat = FileManager.returnDatFileContents(fileName)
        let terrainDatContent = terrainDat!.componentsSeparatedByString("\n")
        let numberOfTerrainTiles = Int(terrainDatContent[1])
        //iterate by number of tiles to store the pngs into some kind of ui or cg image structure    
        var terrainTileDictionary = [String: CGImage]()
        let image = UIImage(named: "data/png/Terrain.png")
        let h = image!.size.height
        let w = image!.size.width
        //need to loop backwards because of how the splitting of tile works. so start index as the number equal to numberOfTerrainTiles
        var counter = 2
        for var index = Int(numberOfTerrainTiles!); index > 0; index-- {
            terrainTileDictionary[terrainDatContent[counter]] = CGImageCreateWithImageInRect(image?.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTerrainTiles!))), w, h/CGFloat(numberOfTerrainTiles!)))
            counter++
        }
        return (terrainTileDictionary,terrainDatContent)
        
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
    
    /*override*/ func drawRect(view: SKNode) {
        let a = MapRenderer()
        var (tileDictionary,tileNames ) = readTerrain()
        let (map,width,height) = readMap()
        for pass in 0...1{
            var x = 0
            var y = 0
            for i in 3 ..< (height + 3){
                var mapLine = Array(map[i].characters)
                for j in 1..<width + 1{
                    let location = CGPointMake(CGFloat(x), CGFloat(y))
                    var typeIndex = -1
                    var typeName = String()
                    switch mapLine[j] {
                        case "G":
                            typeIndex = a.getTileType(j, y: i, curTile: "G", pass: pass)
                            typeName = "grass"
                        case "F":
                            typeIndex = a.getTileType(j, y: i, curTile: "F", pass: pass)
                            typeName = "tree"
                        case "R":
                            typeIndex = a.getTileType(j, y: i, curTile: "R", pass: pass)
                            typeName = "rock"
                        case "D":
                            typeIndex = a.getTileType(j, y: i, curTile: "D", pass: pass)
                            typeName = "dirt"
                        case "W":
                            typeIndex = a.getTileType(j, y: i, curTile: "W", pass: pass)
                            typeName = "wall"
                        case "w":
                            typeIndex = a.getTileType(j, y: i, curTile: "w", pass: pass)
                            typeName = "wall-damaged"
                        case " ":
                            typeIndex = a.getTileType(j, y: i, curTile: " ", pass: pass)
                            typeName = "water"
                        default:
                            typeName = "error"
                            break
                    }
                    if(typeIndex != -1){
                        let type = tileNames[typeIndex]
                        let tile = SKSpriteNode(texture: SKTexture(CGImage: tileDictionary![type]!))
                        if 1 == pass {
                            tile.zPosition = 1
                        }
                        //tile.anchorPoint = CGPointMake(0.5, 0.5);
                        tile.position = location
                        //tile.yScale = -1
                        tile.name = typeName
                            if tile.name == "rock" || tile.name == "tree" || tile.name == "wall" || tile.name == "wall-damaged" {
                            tile.physicsBody = SKPhysicsBody(rectangleOfSize: tile.size)
                            tile.physicsBody?.dynamic = false
                            tile.physicsBody?.resting = false
                            tile.physicsBody?.restitution = 0
                            tile.physicsBody?.density = 100
                            tile.physicsBody?.mass = 100
                            tile.physicsBody?.collisionBitMask = 10
                            tile.physicsBody?.contactTestBitMask = 5
                            tile.physicsBody?.usesPreciseCollisionDetection = true
                        }
                        view.addChild(tile)
                        
                    }
                    x += 32
                }
                y -= 32
                x = 0
            }
        }
        for index in 73..<map.endIndex - 2 {
            let item = map[index].componentsSeparatedByString(" ")
            let placement = CGPointMake(CGFloat(32 * Int(item[2])!), CGFloat(-32 * Int(item[3])!))
            self.drawAsset(placement,sprite: item[0],view: view)
        }    }
   
    func drawAsset(var placement: CGPoint, sprite: String, view: SKNode){
        let fileName = sprite + ".dat"
        let content = FileManager.returnDatFileContents(fileName)
        let contentArray = content!.componentsSeparatedByString("\n")
        
        var image = UIImage()
        var index = 0
        var name = String()
        switch(sprite){
        case "GoldMine":
            image = UIImage(named: "data/png/GoldMine.png")!
            index = 2
            name = "goldmine"
        case "Peasant":
            image = UIImage(named: "data/png/Peasant.png")!
            index = 172
            name = "peasant"
            //placement = CGPointMake(placement.x + 100, placement.y + 30)
        case "TownHall":
            image = UIImage(named: "data/png/TownHall.png")!
            index = 4
            name = "townhall"
        default:
            break
        }
        let h = image.size.height
        let w = image.size.width
        
        let numberOfTiles = Int(contentArray[1]);
        
        let tile = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles!))), w, h/CGFloat(numberOfTiles!)))
        
        let asset = SKSpriteNode(texture: SKTexture(CGImage: tile!))
        asset.position = placement
        asset.name = name
        //asset.yScale = -1
        asset.zPosition = 1
        if asset.name == "peasant"{
            asset.physicsBody = SKPhysicsBody(rectangleOfSize: asset.size)
            asset.physicsBody?.dynamic = false
            asset.physicsBody?.resting = false
            asset.physicsBody?.restitution = 0
            asset.physicsBody?.mass = 1
            asset.physicsBody?.density = 1
            asset.physicsBody?.collisionBitMask = 10
            asset.physicsBody?.contactTestBitMask = 5
            asset.physicsBody?.usesPreciseCollisionDetection = true
        }
        view.addChild(asset)
        
        //self.addChild(mapNode)
        //image = UIImage(CGImage: tile!)
        //image.drawAtPoint(placement)
    }
    
}