//
//  Buildings.swift
//  DavisCraft
//
//  Created by Andrew Tran on 11/3/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit

class Building: SKSpriteNode {
    var health: Float?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        print("building init")
        super.init(texture: texture, color: color, size: size)
        self.zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class townHall: Building{
    var peasantsCreated: Int?
    var peasantLimit: Int?
    
    init(location: CGPoint) {
        print("townHall init")
        let townHallTexture = townHall.texture()
        super.init(texture: townHallTexture, color: SKColor.clearColor(), size: townHallTexture.size())
        self.position = location
        self.name = "townhall"
        self.peasantsCreated = 0
        self.peasantLimit = 0
        self.health = 100.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static func texture() -> SKTexture {
        print("texture")
        let content = FileManager.returnDatFileContents("TownHall.dat")
        let contentArray = content!.componentsSeparatedByString("\n")
        let image = UIImage(named: "data/png/TownHall.png")!
        let index = 2
        let h = image.size.height
        let w = image.size.width
        let numberOfTiles = Int(contentArray[1]);
        let tile = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles!))), w, h/CGFloat(numberOfTiles!)))
        return SKTexture(CGImage: tile!)
    }
    
}