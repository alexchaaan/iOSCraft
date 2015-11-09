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
    var HP: Int?
    var armor: Int?
    var sight: Int?
    var constructionSight: Int?
    var unitSize: Int?
    var unitSpeed: Int?
    var goldCost: Int?
    var lumberCost: Int?
    var foodConsumption: Int?
    var buildTime: Int?
    var attackSteps: Int?
    var reloadSteps: Int?
    var basicDamage: Int?
    var piercingDamage: Int?
    var attackRange: Int?
    var capabilityCount: Int?
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, properties: String) {
        super.init(texture: texture, color: color, size: size)
        let properties          = FileManager.returnDatFileContents(properties, subdirectory: "res")
        let propertiesContent   = properties!.componentsSeparatedByString("\n")
        self.name               = propertiesContent[0].lowercaseString
        self.HP                 = Int(propertiesContent[1])
        self.armor              = Int(propertiesContent[2])
        self.sight              = Int(propertiesContent[3])
        self.constructionSight  = Int(propertiesContent[4])
        self.unitSize           = Int(propertiesContent[5])
        self.unitSpeed          = Int(propertiesContent[6])
        self.goldCost           = Int(propertiesContent[7])
        self.lumberCost         = Int(propertiesContent[8])
        self.foodConsumption    = Int(propertiesContent[9])
        self.buildTime          = Int(propertiesContent[10])
        self.attackSteps        = Int(propertiesContent[11])
        self.reloadSteps        = Int(propertiesContent[12])
        self.basicDamage        = Int(propertiesContent[13])
        self.piercingDamage     = Int(propertiesContent[14])
        self.attackRange        = Int(propertiesContent[15])
        self.capabilityCount    = Int(propertiesContent[16])
        self.zPosition          = 1
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.dynamic = true
        self.physicsBody?.resting = false
        self.physicsBody?.categoryBitMask = 0b1
        self.physicsBody?.contactTestBitMask = 0b11
        self.physicsBody?.collisionBitMask = 0b11
        self.physicsBody?.restitution = 0
        self.physicsBody?.density = 0
        self.physicsBody?.mass = 0
        self.physicsBody?.usesPreciseCollisionDetection = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


