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
        self.zPosition = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

