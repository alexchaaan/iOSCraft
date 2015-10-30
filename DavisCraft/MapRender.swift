//
//  MapRender.swift
//  DavisCraft
//
//  Created by Andrew Tran on 10/16/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit

class MapRender: UIView {
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
    
    override func drawRect(rect: CGRect) {
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
                    switch mapLine[j] {
                        case "G":
                            typeIndex = a.getTileType(j, y: i, curTile: "G", pass: pass)
                        case "F":
                            typeIndex = a.getTileType(j, y: i, curTile: "F", pass: pass)
                        case "R":
                            typeIndex = a.getTileType(j, y: i, curTile: "R", pass: pass)
                        case "D":
                            typeIndex = a.getTileType(j, y: i, curTile: "D", pass: pass)
                        case "W":
                            typeIndex = a.getTileType(j, y: i, curTile: "W", pass: pass)
                        case "w":
                            typeIndex = a.getTileType(j, y: i, curTile: "w", pass: pass)
                        case " ":
                            typeIndex = a.getTileType(j, y: i, curTile: " ", pass: pass)
                        default:
                            break
                    }
                    if(typeIndex != -1){
                        let type = tileNames[typeIndex]
                        UIImage(CGImage: tileDictionary![type]!).drawAtPoint(location)
                    }
                    x += 32
                }
                y += 32
                x = 0
            }
        }
        for index in 73...76{
            let item = map[index].componentsSeparatedByString(" ")
            let placement = CGPointMake(CGFloat(2750 - Int(item[2])!), CGFloat(1800 - Int(item[3])!))
            self.drawTower(placement,sprite: item[0])
        }    }
   
    func drawTower(var placement: CGPoint, sprite: String){
        let fileName = sprite + ".dat"
        let content = FileManager.returnDatFileContents(fileName)
        let contentArray = content!.componentsSeparatedByString("\n")
        
        var image = UIImage()
        var index = 0
        switch(sprite){
        case "GoldMine":
            image = UIImage(named: "data/png/GoldMine.png")!
            index = 2
        case "Peasant":
            image = UIImage(named: "data/png/Peasant.png")!
            index = 172
            placement = CGPointMake(placement.x + 100, placement.y + 30)
        case "TownHall":
            image = UIImage(named: "data/png/TownHall.png")!
            index = 4
        default:
            image = UIImage(named: "data/png/Texture.png")!
            index = 1
        }
        let h = image.size.height
        let w = image.size.width
        
        let numberOfTiles = Int(contentArray[1]);
        
        let tile = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles!))), w, h/CGFloat(numberOfTiles!)))
        
        image = UIImage(CGImage: tile!)
        image.drawAtPoint(placement)
    }
    
}