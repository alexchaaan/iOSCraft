//
//  GuardTower.swift
//  DavisCraft
//
//  Created by Michael Figueroa on 11/7/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit

class GuardTower: Building{
    static let textureSize = texture().size()
    
    init(location: CGPoint) {
        let guardTowerTexture = GuardTower.texture()
        super.init(texture: guardTowerTexture, color: SKColor.clearColor(), size: guardTowerTexture.size(), properties: "GuardTower.dat", location: location)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static func texture() -> SKTexture {
        let content = FileManager.returnDatFileContents("GuardTower.dat")
        let contentArray = content!.componentsSeparatedByString("\n")
        let image = UIImage(named: "data/png/GuardTower.png")!
        let index = 1
        let h = image.size.height
        let w = image.size.width
        let numberOfTiles = Int(contentArray[1]);
        let tile = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles!))), w, h/CGFloat(numberOfTiles!)))
        return SKTexture(CGImage: tile!)
    }
    
}