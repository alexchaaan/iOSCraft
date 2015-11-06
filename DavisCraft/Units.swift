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
    var visualRange: Int?
    var HP: Int?
    var MP: Int?
    var buildTime: Int?
    var goldCost: Int?
    var lumberCost: Int?
    var armor: Int?
    var basicDamage: Int?
    var piercingDamage: Int?
    var baseEffectiveDamage: Int?
    var maxEffectiveDamage: Int?
    var attackRange: Int?
    var moveSpeed: Int?
    
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
        self.visualRange = 4
        self.HP = 30
        self.MP = 0
        self.buildTime = 45
        self.goldCost = 400
        self.lumberCost = 0
        self.armor = 0
        self.basicDamage = 3
        self.piercingDamage = 2
        self.baseEffectiveDamage = 1
        self.maxEffectiveDamage = 5
        self.attackRange = 1
        self.moveSpeed = 10
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