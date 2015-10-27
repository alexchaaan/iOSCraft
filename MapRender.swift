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
        //let path = bundle.pathForResource(fileName, ofType: "map")
        let path = bundle.URLForResource(fileName, withExtension: "map")
        let mapContent = try! String(contentsOfURL: path!, encoding: NSUTF8StringEncoding)
        let mapInfo = mapContent.componentsSeparatedByString("\n")
        
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
    
    //func setTiles(map: Array<String>, width: Int, height: Int){
//        var curTile = String()
//        var topLeftCorner = Int()
//        var topRightCorner = Int()
//        var bottomLeftCorner = Int()
//        var bottomRightCorner = Int()
//        var top = Int()
//        var bottom = Int()
//        var right = Int()
//        var left = Int()
//        for i in 3 ..< (height + 3){
//            var jNum = 0
//            for j in map[i].characters{
//                if (jNum > 0 && jNum < map[i].lengthOfBytesUsingEncoding(NSUTF8StringEncoding)){
//                    switch j {
//                    case "G": curTile = "G"
//                    case "F": curTile = "F"
//                    case "R": curTile = "R"
//                    case "D": curTile = "D"
//                    case "W": curTile = "W"
//                    case "w": curTile = "w"
//                    case " ": curTile = " "
//                    default: break
//                    }
//                    //top left corner
//                    var yIndex = i - 1
//                    var xIndex = jNum - 1
//                    let str = map[yIndex]
//                    
//                }
//                jNum++
//            }
//        }
//    }
    
    
    override func drawRect(rect: CGRect) {
        var tileDictionary = readTerrain()
        var x = 0
        var y = 0
        var dummy = 0
//let location = CGPointMake(100 , 100)
        let (map,width,height) = readMap()
        for i in 3 ..< (height + 3){
            var jNum = 0
            for j in map[i].characters{ //make sure to account for the extra 2 thing later
                //let location = CGPointMake(CGFloat(y), CGFloat(x))
                if(jNum > 0 && jNum < map[i].lengthOfBytesUsingEncoding(NSUTF8StringEncoding)){
                    let location = CGPointMake(CGFloat(y), CGFloat(x))
                    switch j {
                    case "G":
                            UIImage(CGImage: tileDictionary!["grass-0"]!).drawAtPoint(location)
                    case "F":
                            UIImage(CGImage: tileDictionary!["tree-a"]!).drawAtPoint(location)
                    case "R":
                            UIImage(CGImage: tileDictionary!["rock-0"]!).drawAtPoint(location)
                    case "D":
                            UIImage(CGImage: tileDictionary!["dirt-1"]!).drawAtPoint(location)
                    case "W":
                            UIImage(CGImage: tileDictionary!["wall-0"]!).drawAtPoint(location)
                    case "w":
                            UIImage(CGImage: tileDictionary!["wall-damaged-0"]!).drawAtPoint(location)
                    case " ":
                            UIImage(CGImage: tileDictionary!["water-0"]!).drawAtPoint(location)
                    default:
                            UIImage(CGImage: tileDictionary!["dirt-a"]!).drawAtPoint(location)
                    }
                //}
                y += 32
                }
                jNum++
            }
            x += 32
            y = 0
        }
        for index in 73...76{
            let item = map[index].componentsSeparatedByString(" ")
            var placement = CGPointMake(CGFloat(2750 - Int(item[2])!), CGFloat(1800 - Int(item[3])!))
            self.drawTower(placement,sprite: item[0])
        }
        //UIImage(CGImage: tileDictionary!["grass-a"]!).drawAtPoint(location)
    }
   
    
//    int CGraphicTileset::FindTile(const std::string &tilename) const{
//    auto Iterator = DMapping.find(tilename);
//    if(DMapping.end() != Iterator){
//    return Iterator->second;
//    }
//    return -1;
//    }
    
    func drawTower(var placement: CGPoint, sprite: String){ // Does print 2 dudes, just overlaps them.
        let fileName = sprite
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "dat")
        let content = try! String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        let contentArray = content.componentsSeparatedByString("\n")
        
        var image = UIImage()
        var index = 0
        switch(sprite){
        case "GoldMine":
            image = UIImage(named: "GoldMine.png")!
            index = 2
        case "Peasant":
            image = UIImage(named: "Peasant.png")!
            index = 172
            placement = CGPointMake(placement.x + 100, placement.y + 30)
        case "TownHall":
            image = UIImage(named: "TownHall.png")!
            index = 4
        default:
            image = UIImage(named: "Texture.png")!
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