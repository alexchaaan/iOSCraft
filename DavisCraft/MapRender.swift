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
    
    static var MapWidth: CGFloat = 0
    static var MapHeight: CGFloat = 0
    
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
    
    func drawRect(view: SKNode) {
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
                    let tile: Tile
                    switch mapLine[j] {
                        case "G":
                            typeIndex = a.getTileType(j, y: i, curTile: "G", pass: pass)
                            tile = TileGrass(location: location)
                        case "F":
                            typeIndex = a.getTileType(j, y: i, curTile: "F", pass: pass)
                            tile = TileTree(location: location)
                        case "R":
                            typeIndex = a.getTileType(j, y: i, curTile: "R", pass: pass)
                            tile = TileRock(location: location)
                        case "D":
                            typeIndex = a.getTileType(j, y: i, curTile: "D", pass: pass)
                            tile = TileDirt(location: location)
                        case "W":
                            typeIndex = a.getTileType(j, y: i, curTile: "W", pass: pass)
                            tile = TileWall(location: location)
                        case "w":
                            typeIndex = a.getTileType(j, y: i, curTile: "w", pass: pass)
                            tile = TileWall(location: location)
                        case " ":
                            typeIndex = a.getTileType(j, y: i, curTile: " ", pass: pass)
                            tile = TileWater(location: location)
                        default:
                            tile = TileGrass(location: location)
                            break
                    }
                    
                    if(typeIndex != -1){
                        let type = tileNames[typeIndex]
                        tile.texture = SKTexture(CGImage: tileDictionary![type]!)
                        tile.size = (tile.texture?.size())!
                        if 1 == pass {
                            tile.zPosition = 5
                        }
                        if(tile is TileTree || tile is TileRock){
                            tile.setPhysics()
                        }
                        view.addChild(tile)
                        
                    }
                    x += 32
                }
                y -= 32
                if i < (height + 2) {
                    x = 0
                }
            }
            MapRender.MapWidth = CGFloat(x)
            MapRender.MapHeight = CGFloat(y)
        }
        let ps = Peasant(location: CGPointMake(CGFloat(100),CGFloat(-100)))
        view.addChild(ps)
        for index in 73..<map.endIndex - 2 {
            let item = map[index].componentsSeparatedByString(" ")
            let placement = CGPointMake(CGFloat(32 * Int(item[2])!), CGFloat(-32 * Int(item[3])!))
            self.drawAsset(placement,sprite: item[0],view: view)
        }    }
   
    func drawAsset(placement: CGPoint, sprite: String, view: SKNode){

        switch(sprite){
        case "GoldMine":
            let goldmine = GoldMine(location: placement)
            view.addChild(goldmine)
        case "Peasant":
            let peasant = Peasant(location: placement)
            view.addChild(peasant)
        case "TownHall":
            let townhall = TownHall(location: placement)
            view.addChild(townhall)
        default:
            break
        }

    }
    
}