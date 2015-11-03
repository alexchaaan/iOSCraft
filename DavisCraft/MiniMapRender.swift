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
    var x: CGFloat = 0
    var y: CGFloat = 0
    var vpStartX: CGFloat = 0
    var vpStartY: CGFloat = 0
    var vpWidth: CGFloat = 0
    var vpHeight: CGFloat = 0
    var mapRatioX: CGFloat = 1.0
    var mapRatioY: CGFloat = 1.0
    var alreadyDrew: Bool = false
    
    init(frame: CGRect, x_min: CGFloat, y_min: CGFloat, width: CGFloat, height: CGFloat) {
        vpStartX = x_min
        vpStartY = y_min
        vpWidth = width
        vpHeight = height
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        self.drawMiniMap()
        self.drawViewport()
    }
    
    func drawMiniMap() {
        let step: CGFloat = 1.8
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, step)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let (map,_,width) = readMap()
        var components: [CGFloat]
        for i in 2 ..< (width + 2){
            for j in map[i].characters{ //make sure to account for the extra 2 thing later
                switch j {
                case "G":
                    components = [0.3, 0.8, 0.3, 0.8]
                case "F":
                    components = [0.3, 0.3, 0.1, 1.0]
                case "R":
                    components = [0.6, 0.6, 0.6, 1.0]
                default:
                    components = [0.5, 0.5, 0.2, 1.0]
                }
                drawLine(context, colorSpace: colorSpace, components: components, begin_x: x, begin_y: y, end_x: x + step, end_y: y + step)
                x += step
            }
            y += step
            if i != width + 1 {
                x = 0
            }
        }
        mapRatioX = CGFloat(3000) / (x - step)
        mapRatioY = CGFloat(2000) / (y - step)
        alreadyDrew = true
        for index in 73...76{
            let item = map[index].componentsSeparatedByString(" ")
            components = [0.0, 1.0, 0.0, 1.0]   // Bright Green color Squares
            drawSquare(context, colorSpace: colorSpace, components: components, sprite: item[0], the_x: CGFloat(2750 - Int(item[2])!) / mapRatioX, the_y: CGFloat(1800 - Int(item[3])!) / mapRatioY)
            
        }
        
    }
    
    func drawLine(context: CGContext?, colorSpace: CGColorSpace?, components: [CGFloat], begin_x: CGFloat, begin_y: CGFloat, end_x: CGFloat, end_y: CGFloat) {
        let color = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        CGContextMoveToPoint(context, begin_x, begin_y)
        CGContextAddLineToPoint(context, end_x, end_y)
        CGContextStrokePath(context)
    }
    
    /* Draw Sprites on the MiniMap */
    func drawSquare(context: CGContext?, colorSpace: CGColorSpace?, components: [CGFloat], sprite: String, the_x: CGFloat, var the_y: CGFloat) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        let fileName = sprite + ".dat"
        let content = FileManager.returnDatFileContents(fileName)
        let contentArray = content!.componentsSeparatedByString("\n")
        var image = UIImage()
        var index = 0
        switch(sprite) {
            case "GoldMine":
                image = UIImage(named: "data/png/GoldMine.png")!
                index = 2
                break
            case "Peasant":
                image = UIImage(named: "data/png/Peasant.png")!
                index = 172
                break
            case "TownHall":
                image = UIImage(named: "data/png/TownHall.png")!
                index = 4
                break
            default:
                image = UIImage(named: "data/png/Texture.png")!
                index = 1
                break
        }
        width = image.size.width
        height = image.size.height
        let numberOfTiles = Int(contentArray[1]);
        the_y += (height - (CGFloat(index)*(height/CGFloat(numberOfTiles!)))) / mapRatioY
        
        CGContextSetLineWidth(context, height / CGFloat(numberOfTiles!) / mapRatioY)
        let color = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        CGContextMoveToPoint(context, the_x, the_y)
        CGContextAddLineToPoint(context, the_x + width / mapRatioX, the_y)
        CGContextStrokePath(context)
    }
    
    func drawViewport() {
        let x_max: CGFloat = (vpStartX + vpWidth) / mapRatioX
        let y_max: CGFloat = (vpStartY + vpHeight) / mapRatioY
        let x_min: CGFloat = vpStartX / mapRatioX
        let y_min: CGFloat = vpStartY / mapRatioY
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 1.0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [1.0, 1.0, 1.0, 0.8]
        drawLine(context, colorSpace: colorSpace, components: components, begin_x: x_min, begin_y: y_min, end_x: x_max, end_y: y_min)
        drawLine(context, colorSpace: colorSpace, components: components, begin_x: x_max, begin_y: y_min, end_x: x_max, end_y: y_max)
        drawLine(context, colorSpace: colorSpace, components: components, begin_x: x_max, begin_y: y_max, end_x: x_min, end_y: y_max)
        drawLine(context, colorSpace: colorSpace, components: components, begin_x: x_min, begin_y: y_max, end_x: x_min, end_y: y_min)
    }
    
    
    func getDimensions() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        if alreadyDrew {
            return (x, y, mapRatioX, mapRatioY)
        }
        else {
            return (0, 0, mapRatioX, mapRatioY)
        }
    }
    
    
}
