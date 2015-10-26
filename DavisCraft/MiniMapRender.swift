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
        var x: CGFloat = 0
        var y: CGFloat = 0
        //let location = CGPointMake(100 , 100)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 1.5)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let step: CGFloat = 1.8
        let (map,_,width) = readMap()
        for i in 2 ..< (width + 2){
            for j in map[i].characters{ //make sure to account for the extra 2 thing later
                switch j {
                    
                case "G":
                    let components: [CGFloat] = [0.3, 0.8, 0.3, 1.0]
                    let color = CGColorCreate(colorSpace, components)
                    CGContextSetStrokeColorWithColor(context, color)
                    CGContextMoveToPoint(context, x, y)
                    CGContextAddLineToPoint(context, x+step, y+step)
                    CGContextStrokePath(context)
                case "F":
                    let components: [CGFloat] = [0.3, 0.3, 0.1, 1.0]
                    let color = CGColorCreate(colorSpace, components)
                    CGContextSetStrokeColorWithColor(context, color)
                    CGContextMoveToPoint(context, x, y)
                    CGContextAddLineToPoint(context, x+step, y+step)
                    CGContextStrokePath(context)
                case "R":
                    let components: [CGFloat] = [0.6, 0.6, 0.6, 1.0]
                    let color = CGColorCreate(colorSpace, components)
                    CGContextSetStrokeColorWithColor(context, color)
                    CGContextMoveToPoint(context, x, y)
                    CGContextAddLineToPoint(context, x+step, y+step)
                    CGContextStrokePath(context)
                default:
                    let components: [CGFloat] = [0.5, 0.5, 0.2, 1.0]
                    let color = CGColorCreate(colorSpace, components)
                    CGContextSetStrokeColorWithColor(context, color)
                    CGContextMoveToPoint(context, x, y)
                    CGContextAddLineToPoint(context, x+step, y+step)
                    CGContextStrokePath(context)
                    
                }
                y += step
            }
            x += step
            y = 0
        }
        
    }
    
}
