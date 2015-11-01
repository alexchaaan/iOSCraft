//
//  MiniMapRender.swift
//  DavisCraft
//
//  Created by Charles_Fox_W on 10/25/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit

class MiniMapRender: UIView {
    //each map tile is 32x32
    let bundle = NSBundle.mainBundle()
    func readTerrain() -> Dictionary <String, CGImage>? {
        //read in the tiles for the map
        let fileName = "Terrain.dat"
        let terrainDat = FileManager.returnDatFileContents(fileName)
        let terrainDatContent = terrainDat!.componentsSeparatedByString("\n")
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
        let fileName = "2player.map"
        let mapContent = FileManager.returnDatFileContents(fileName, subdirectory: "map")
        let mapInfo = mapContent!.componentsSeparatedByString("\n")
        let mapName = mapInfo[0]
        print(mapName)
        //        let line2 = mapInfo[2]
        //        print(line2)
        let mapDimension = mapInfo[1].componentsSeparatedByString(" ")
        print(mapDimension)
        //2 was added because tiles need to look around themselves
        //without extra then edge tiles will go out of bounds when looking around
        let mapWidth = Int(mapDimension[0])!
        print(mapWidth)
        let mapHeight = Int(mapDimension[1])!
        print(mapHeight)
        //setTiles(mapInfo, width: mapWidth, height: mapHeight)
        return (mapInfo, mapWidth, mapHeight)
        
        
    }
    
    override func drawRect(rect: CGRect) {
        var x: CGFloat = 0
        var y: CGFloat = 0
        //let location = CGPointMake(100 , 100)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 1.5)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let step: CGFloat = 1.8
        let (map,_,width) = readMap()
        var components: [CGFloat]
        for i in 2 ..< (width + 2){
            for j in map[i].characters{ //make sure to account for the extra 2 thing later
                switch j {
                case "G":
                    components = [0.3, 0.8, 0.3, 1.0]
                case "F":
                    components = [0.3, 0.3, 0.1, 1.0]
                case "R":
                    components = [0.6, 0.6, 0.6, 1.0]
                default:
                    components = [0.5, 0.5, 0.2, 1.0]
                }
                drawLine(context, colorSpace: colorSpace, components: components, x: x, y: y, step: step)
                x += step
            }
            y += step
            x = 0
        }
        
    }
    
    func drawLine(context: CGContext?, colorSpace: CGColorSpace?, components: [CGFloat], x: CGFloat, y: CGFloat, step: CGFloat) {
        let color = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        CGContextMoveToPoint(context, x, y)
        CGContextAddLineToPoint(context, x+step, y+step)
        CGContextStrokePath(context)
    }
    
}
