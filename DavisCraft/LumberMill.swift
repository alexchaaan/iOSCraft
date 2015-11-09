//
//  LumberMill.swift
//  DavisCraft
//
//  Created by Michael Figueroa on 11/7/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit

class LumberMill: Building{
    static let textureSize = texture().size()
    
    init(location: CGPoint) {
        let lumberMillTexture = LumberMill.texture()
        super.init(texture: lumberMillTexture, color: SKColor.clearColor(), size: lumberMillTexture.size(), properties: "LumberMill.dat", location: location)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static func texture() -> SKTexture {
        let content = FileManager.returnDatFileContents("LumberMill.dat")
        let contentArray = content!.componentsSeparatedByString("\n")
        let image = UIImage(named: "data/png/LumberMill.png")!
        let index = 2
        let h = image.size.height
        let w = image.size.width
        let numberOfTiles = Int(contentArray[1]);
        let tile = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles!))), w, h/CGFloat(numberOfTiles!)))
        return SKTexture(CGImage: tile!)
    }
    
}