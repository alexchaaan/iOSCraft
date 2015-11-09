//
//  TownHall.swift
//  DavisCraft
//
//  Created by Michael Figueroa on 11/5/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit

class TownHall: Building{
    static let textureSize = texture().size()
    
    init(location: CGPoint) {
        print("Make TownHall")
        let townHallTexture = TownHall.texture()
        super.init(texture: townHallTexture, color: SKColor.clearColor(), size: townHallTexture.size(), properties: "TownHall.dat", location: location)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static func texture() -> SKTexture {
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