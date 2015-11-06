//
//  TileRock.swift
//  DavisCraft
//
//  Created by Michael Figueroa on 11/5/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit

class TileRock: Tile{
    
    init(location: CGPoint) {
        super.init(texture: nil, color: SKColor.clearColor(), size: CGSize.zero)
        self.position = location
        self.name = "rock"
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.dynamic = false
        self.physicsBody?.resting = false
        self.physicsBody?.restitution = 0
        self.physicsBody?.density = 0
        self.physicsBody?.mass = 0
        self.physicsBody?.collisionBitMask = 10
        self.physicsBody?.contactTestBitMask = 5
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    private static func texture() -> SKTexture {
    //        let content = FileManager.returnDatFileContents("TownHall.dat")
    //        let contentArray = content!.componentsSeparatedByString("\n")
    //        let image = UIImage(named: "data/png/TownHall.png")!
    //        let index = 2
    //        let h = image.size.height
    //        let w = image.size.width
    //        let numberOfTiles = Int(contentArray[1]);
    //        let tile = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles!))), w, h/CGFloat(numberOfTiles!)))
    //        return SKTexture(CGImage: tile!)
    //    }
    
}