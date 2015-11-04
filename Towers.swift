//
//  Towers.swift
//  DavisCraft
//
//  Created by Andrew Tran on 11/3/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit

class TownHall: SKSpriteNode {
    var location: CGPoint?
    var peasantsCreated: Int?
    var peasantLimit: Int?
    
    func constructor(){
        peasantsCreated = 0
        peasantLimit = 5
    }
    
    func createTower(map: SKNode) {
        let content = FileManager.returnDatFileContents("TownHall.dat")
        let contentArray = content!.componentsSeparatedByString("\n")
        
        var image = UIImage()
        var index = 2
        
        image = UIImage(named: "data/png/TownHall.png")!
        
        let h = image.size.height
        let w = image.size.width
        
        let numberOfTiles = Int(contentArray[1]);
        
        let tile = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles!))), w, h/CGFloat(numberOfTiles!)))
        
        let tower = SKSpriteNode(texture: SKTexture(CGImage: tile!))
        //let location = CGPointMake(CGFloat(90 * 32), CGFloat(40 * 32))
        tower.position = /*location*/convertPoint(CGPointMake(2800, -1800), toNode: map)
        tower.name = "townhall"
        location = tower.position
        //peasant.yScale = -1
        tower.zPosition = 1
        map.addChild(tower)

    }
}