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
    var HP = -1
    var armor = -1
    var sight = -1
    var constructionSight = -1
    var unitSize = -1
    var unitSpeed = -1
    var goldCost = -1
    var lumberCost = -1
    var foodConsumption = -1
    var buildTime = -1
    var attackSteps = -1
    var reloadSteps = -1
    var basicDamage = -1
    var piercingDamage = -1
    var attackRange = -1
    var capabilityCount = -1
    var appearingOrder = -1
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, properties: String, location: CGPoint) {
        super.init(texture: texture, color: color, size: size)
        let properties          = FileManager.returnDatFileContents(properties, subdirectory: "res")
        let propertiesContent   = properties!.componentsSeparatedByString("\n")
        self.position           = CGPointMake(location.x + (texture?.size().width)!/2, location.y + (texture?.size().height)!/2)
        self.name               = propertiesContent[0].lowercaseString
        self.HP                 = Int(propertiesContent[1])!
        self.armor              = Int(propertiesContent[2])!
        self.sight              = Int(propertiesContent[3])!
        self.constructionSight  = Int(propertiesContent[4])!
        self.unitSize           = Int(propertiesContent[5])!
        self.unitSpeed          = Int(propertiesContent[6])!
        self.goldCost           = Int(propertiesContent[7])!
        self.lumberCost         = Int(propertiesContent[8])!
        self.foodConsumption    = Int(propertiesContent[9])!
        self.buildTime          = Int(propertiesContent[10])!
        self.attackSteps        = Int(propertiesContent[11])!
        self.reloadSteps        = Int(propertiesContent[12])!
        self.basicDamage        = Int(propertiesContent[13])!
        self.piercingDamage     = Int(propertiesContent[14])!
        self.attackRange        = Int(propertiesContent[15])!
        self.capabilityCount    = Int(propertiesContent[16])!
        self.appearingOrder     = 0
        self.zPosition = 2
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width - 1, self.size.height - 1))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.dynamic = true
        self.physicsBody?.resting = true
        self.physicsBody?.categoryBitMask = 0b10
        self.physicsBody?.contactTestBitMask = 0b111
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.restitution = 0
        self.physicsBody?.density = 0
        self.physicsBody?.mass = 0
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func setNewBuildingTint(newBuilding: Building) {
        if(newBuilding.physicsBody?.allContactedBodies().count == 0) {
            newBuilding.colorBlendFactor = CGFloat(0.5)
            newBuilding.color = SKColor.greenColor()
        }
        else {
            newBuilding.colorBlendFactor = CGFloat(0.5)
            newBuilding.color = SKColor.redColor()
        }
    }
    
    static func positionOnTile(nodeToBePositioned: Building) {
        let nodes = nodeToBePositioned.parent!.nodesAtPoint(nodeToBePositioned.position)
        for node in nodes {
            if (node is Tile) {
                nodeToBePositioned.position = node.position
                break
            }
        }
    }
    
}

