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
    let bundle = NSBundle.mainBundle()
    func readTerrain() -> Dictionary <String, CGImage>? {
        //read in the tiles for the map
        let fileName = "Terrain"
        let terrainDatPath = bundle.pathForResource(fileName, ofType: "dat")
        let terrainDat = try! String(contentsOfFile: terrainDatPath!, encoding: NSUTF8StringEncoding)
        let terrainDatContent = terrainDat.componentsSeparatedByString("\n")
        let terrainPngPath = terrainDatContent[0]
        let numberOfTerrainTiles = Int(terrainDatContent[1])
        //iterate by number of tiles to store the pngs into some kind of ui or cg image structure    
        var terrainTileDictionary = [String: CGImage]()
        let image = UIImage(named: "Terrain.png")
        let h = image!.size.height
        let w = image!.size.width
        //need to loop backwards because of how the splitting of tile works. so start index as the number equal to numberOfTerrainTiles
        //for index in Int(numberOfTerrainTiles!) ... 1 {
        var counter = 2
        for var index = Int(numberOfTerrainTiles!); index > 0; index-- {
            terrainTileDictionary[terrainDatContent[counter]] = CGImageCreateWithImageInRect(image?.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTerrainTiles!))), w, h/CGFloat(numberOfTerrainTiles!)))
            counter++
        }
        return terrainTileDictionary
        
    }

    func readMap() -> (Array<String>, Int, Int){
        //maybe havve button to give map filename
        let fileName = "2player"
        let path = bundle.pathForResource(fileName, ofType: "dat")
        let mapContent = try! String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        let mapInfo = mapContent.componentsSeparatedByString("\n")
        let mapName = mapInfo[0]
        let mapDimension = mapInfo[1].componentsSeparatedByString(" ")
        //2 was added because tiles need to look around themselves
        //without extra then edge tiles will go out of bounds when looking around
        let mapHeight = Int(mapDimension[0])! + 2
        let mapWidth = Int(mapDimension[1])! + 2
        return (mapInfo, mapHeight, mapWidth)
        
        
    }
    
    override func drawRect(rect: CGRect) {
        var tileDictionary = readTerrain()
        var x = 0
        var y = 0
//let location = CGPointMake(100 , 100)
        let (map,height,width) = readMap()
        for var i = 3; i < (width + 3); i++ {
            for var j in map[i].characters{ //make sure to account for the extra 2 thing later
                let location = CGPointMake(CGFloat(x), CGFloat(y))
                switch j {
                case "G":
                        UIImage(CGImage: tileDictionary!["grass-a"]!).drawAtPoint(location)
                case "F":
                        UIImage(CGImage: tileDictionary!["tree-a"]!).drawAtPoint(location)
                case "R":
                        UIImage(CGImage: tileDictionary!["rubble-a"]!).drawAtPoint(location)
                default:
                        UIImage(CGImage: tileDictionary!["dirt-a"]!).drawAtPoint(location)
                }
                y += 32
            }
            x += 32
            y = 0
        }
        //UIImage(CGImage: tileDictionary!["grass-a"]!).drawAtPoint(location)
    }
    
    

}