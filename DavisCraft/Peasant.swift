//
//  Peasant.swift
//  DavisCraft
//
//  Created by Michael Figueroa on 11/5/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit

class Peasant: Unit {
    var isCuttingTree: Bool?
    var isMining: Bool?
    
    
    init(location: CGPoint) {
        let peasantTexture = Peasant.texture()
        super.init(texture: peasantTexture, color: SKColor.clearColor(), size: peasantTexture.size(), properties: "Peasant.dat")
        self.position = location
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
    
    func build(buildingString: String, location: CGPoint) -> Building
    {
        var newBuilding : Building?
        
        switch(buildingString){
        case "TownHall":
            let loc = CGPointMake(location.x - TownHall.textureSize.width/2, location.y - TownHall.textureSize.height/2)
            newBuilding = TownHall(location: loc)
        case "Barracks":
            let loc = CGPointMake(location.x - Barracks.textureSize.width/2, location.y - Barracks.textureSize.height/2)
            newBuilding = Barracks(location: loc)
        case "BlackSmith":
            let loc = CGPointMake(location.x - BlackSmith.textureSize.width/2, location.y - BlackSmith.textureSize.height/2)
            newBuilding = BlackSmith(location: loc)
        case "Farm":
            let loc = CGPointMake(location.x - Farm.textureSize.width/2, location.y - Farm.textureSize.height/2)
            newBuilding = Farm(location: loc)
        case "LumberMill":
            let loc = CGPointMake(location.x - LumberMill.textureSize.width/2, location.y - LumberMill.textureSize.height/2)
            newBuilding = LumberMill(location: loc)
        case "ScoutTower":
            let loc = CGPointMake(location.x - ScoutTower.textureSize.width/2, location.y - ScoutTower.textureSize.height/2)
            newBuilding = ScoutTower(location: loc)
        case "GuardTower": //these bottom three can't be made by peasant
            let loc = CGPointMake(location.x - GuardTower.textureSize.width/2, location.y - GuardTower.textureSize.height/2)
            newBuilding = GuardTower(location: loc)
        case "Castle":
            let loc = CGPointMake(location.x - Castle.textureSize.width/2, location.y - Castle.textureSize.height/2)
            newBuilding = Castle(location: loc)
        case "Keep":
            let loc = CGPointMake(location.x - Keep.textureSize.width/2, location.y - Keep.textureSize.height/2)
            newBuilding = Keep(location: loc)
        default:
            newBuilding = nil
            print("CANNOT BUILD")
        }
        return newBuilding!

    }
    
}