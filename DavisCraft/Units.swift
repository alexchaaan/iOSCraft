//
//  Units.swift
//  DavisCraft
//
//  Created by Michael Figueroa on 11/5/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit

class Unit: SKSpriteNode{
    var health: Float?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class Peasant: Unit {
    var isCuttingTree: Bool?
    var isMining: Bool?

    
    init(location: CGPoint) {
        let peasantTexture = Peasant.texture()
        super.init(texture: peasantTexture, color: SKColor.clearColor(), size: peasantTexture.size())
        self.position = location
        self.name = "peasant"
        self.isCuttingTree = false
        self.isMining = false
        self.health = 100.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static func texture() -> SKTexture {
        let content = FileManager.returnDatFileContents("Peasant.dat")
        let contentArray = content!.componentsSeparatedByString("\n")
        let image = UIImage(named: "data/png/Peasant.png")!
        let index = 152
        let h = image.size.height
        let w = image.size.width
        let numberOfTiles = Int(contentArray[1]);
        let tile = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles!))), w, h/CGFloat(numberOfTiles!)))
        return SKTexture(CGImage: tile!)
    }

}