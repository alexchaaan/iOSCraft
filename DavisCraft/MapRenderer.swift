//
//  MapRenderer.swift
//  DavisCraft
//
//  Created by Andrew Tran on 10/26/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit
import SpriteKit

class MapRenderer {
    var DGrassIndices = [Int]()
    var DTreeIndices = [Int]()
    var DDirtIndices = [Int]()
    var DWaterIndices = [Int]()
    var DRockIndices = [Int]()
    var DWallIndices = [Int]()
    var DWallDamagedIndices = [Int]()
    var DRubbleIndices = [Int]()
    var DPixelIndices = [Int]()
    
    var DTreeUnknown = [Int: Int]()
    var DWaterUnknown = [Int: Int]()
    var DDirtUnknown = [Int: Int]()
    var DRockUnkown = [Int: Int]()
    
    var DMappingTiff = [String: Int]()
    var Map = [String]()
    
    
    init(){
        GrabMapContent()
        RetrieveFromDat()
        
        VectorFiller(&DGrassIndices, prefix: "grass-")
        VectorFiller(&DDirtIndices, prefix: "dirt-")
        VectorFiller(&DRockIndices, prefix: "rock-")
        VectorFiller(&DTreeIndices, prefix: "tree-")
        VectorFiller(&DWaterIndices, prefix: "water-")
        VectorFiller(&DWallIndices, prefix: "wall-")
        VectorFiller(&DWallDamagedIndices, prefix: "wall-damaged-")
        VectorFiller(&DRubbleIndices, prefix: "rubble-")
        
        tileMapping()
        
    }
    
    func tileMapping(){
        DTreeIndices[0x0A] = DTreeIndices[0x03];
        DTreeIndices[0x0B] = DTreeIndices[0x03];
        DTreeIndices[0x23] = DTreeIndices[0x03];
        DTreeIndices[0x2B] = DTreeIndices[0x03];
        DTreeIndices[0x0E] = DTreeIndices[0x06];
        DTreeIndices[0x22] = DTreeIndices[0x06];
        DTreeIndices[0x26] = DTreeIndices[0x06];
        DTreeIndices[0x2E] = DTreeIndices[0x06];
        DTreeIndices[0x0F] = DTreeIndices[0x07];
        DTreeIndices[0x27] = DTreeIndices[0x07];
        DTreeIndices[0x2F] = DTreeIndices[0x07];
        DTreeIndices[0x18] = DTreeIndices[0x11];
        DTreeIndices[0x19] = DTreeIndices[0x11];
        DTreeIndices[0x39] = DTreeIndices[0x11];
        DTreeIndices[0x30] = DTreeIndices[0x14];
        DTreeIndices[0x34] = DTreeIndices[0x14];
        DTreeIndices[0x32] = DTreeIndices[0x16];
        DTreeIndices[0x3A] = DTreeIndices[0x1A];
        
        DTreeIndices[0x11] = DTreeIndices[0x10];
        DTreeIndices[0x14] = DTreeIndices[0x10];
        DTreeIndices[0x15] = DTreeIndices[0x10];
        
        DTreeIndices[0x39] = DTreeIndices[0x38];
        DTreeIndices[0x3C] = DTreeIndices[0x38];
        DTreeIndices[0x3D] = DTreeIndices[0x38];
        
        DDirtIndices[0x03] = DDirtIndices[0x02];
        DDirtIndices[0x05] = DDirtIndices[0x02];
        DDirtIndices[0x06] = DDirtIndices[0x02];
        DDirtIndices[0x07] = DDirtIndices[0x02];
        
        DDirtIndices[0x09] = DDirtIndices[0x08];
        DDirtIndices[0x21] = DDirtIndices[0x08];
        DDirtIndices[0x28] = DDirtIndices[0x08];
        DDirtIndices[0x29] = DDirtIndices[0x08];
        
        DDirtIndices[0x14] = DDirtIndices[0x10];
        DDirtIndices[0x84] = DDirtIndices[0x10];
        DDirtIndices[0x90] = DDirtIndices[0x10];
        DDirtIndices[0x94] = DDirtIndices[0x10];
        
        DDirtIndices[0x60] = DDirtIndices[0x40];
        DDirtIndices[0xA0] = DDirtIndices[0x40];
        DDirtIndices[0xC0] = DDirtIndices[0x40];
        DDirtIndices[0xE0] = DDirtIndices[0x40];
        
        // Corner three
        DDirtIndices[0x0A] = DDirtIndices[0x0B];
        DDirtIndices[0x0F] = DDirtIndices[0x0B];
        DDirtIndices[0x25] = DDirtIndices[0x0B];
        DDirtIndices[0x27] = DDirtIndices[0x0B];
        DDirtIndices[0x2D] = DDirtIndices[0x0B];
        DDirtIndices[0x2B] = DDirtIndices[0x0B];
        DDirtIndices[0x2F] = DDirtIndices[0x0B];
        
        DDirtIndices[0x12] = DDirtIndices[0x16];
        DDirtIndices[0x17] = DDirtIndices[0x16];
        DDirtIndices[0x85] = DDirtIndices[0x16];
        DDirtIndices[0x87] = DDirtIndices[0x16];
        DDirtIndices[0x95] = DDirtIndices[0x16];
        DDirtIndices[0x96] = DDirtIndices[0x16];
        DDirtIndices[0x97] = DDirtIndices[0x16];
        
        DDirtIndices[0x48] = DDirtIndices[0x68];
        DDirtIndices[0x69] = DDirtIndices[0x68];
        DDirtIndices[0xA1] = DDirtIndices[0x68];
        DDirtIndices[0xA9] = DDirtIndices[0x68];
        DDirtIndices[0xE1] = DDirtIndices[0x68];
        DDirtIndices[0xE8] = DDirtIndices[0x68];
        DDirtIndices[0xE9] = DDirtIndices[0x68];
        
        DDirtIndices[0x50] = DDirtIndices[0xD0];
        DDirtIndices[0xA4] = DDirtIndices[0xD0];
        DDirtIndices[0xB4] = DDirtIndices[0xD0];
        DDirtIndices[0xD4] = DDirtIndices[0xD0];
        DDirtIndices[0xE4] = DDirtIndices[0xD0];
        DDirtIndices[0xF0] = DDirtIndices[0xD0];
        DDirtIndices[0xF4] = DDirtIndices[0xD0];
        
        var Hamming = [Int]()
        MakeHammingSet(0x5A, hammingset: &Hamming)
        
        for Value in Hamming{
            if -1 == DDirtIndices[Value | 0x24]{
                DDirtIndices[Value | 0x24] = DDirtIndices[0x7E]
            }
            if(-1 == DDirtIndices[Value | 0x81]){
                DDirtIndices[Value | 0x81] = DDirtIndices[0xDB]
            }
        }
        
        DDirtIndices[0x1D] = DDirtIndices[0xFF];
        DDirtIndices[0x3D] = DDirtIndices[0xFF];
        DDirtIndices[0x9D] = DDirtIndices[0xFF];
        
        DDirtIndices[0x63] = DDirtIndices[0xFF];
        DDirtIndices[0x67] = DDirtIndices[0xFF];
        DDirtIndices[0xE3] = DDirtIndices[0xFF];
        
        DDirtIndices[0xB8] = DDirtIndices[0xFF];
        DDirtIndices[0xB9] = DDirtIndices[0xFF];
        DDirtIndices[0xBC] = DDirtIndices[0xFF];
        
        DDirtIndices[0xC6] = DDirtIndices[0xFF];
        DDirtIndices[0xC7] = DDirtIndices[0xFF];
        DDirtIndices[0xE6] = DDirtIndices[0xFF];
        
        DDirtIndices[0xBD] = DDirtIndices[0xFF];
        DDirtIndices[0xE7] = DDirtIndices[0xFF];
        
        DWaterIndices[0x00] = DDirtIndices[0xFF];
        DWaterIndices[0x01] = DWaterIndices[0x00];
        DWaterIndices[0x02] = DWaterIndices[0x00];
        DWaterIndices[0x04] = DWaterIndices[0x00];
        DWaterIndices[0x08] = DWaterIndices[0x00];
        DWaterIndices[0x10] = DWaterIndices[0x00];
        DWaterIndices[0x20] = DWaterIndices[0x00];
        DWaterIndices[0x40] = DWaterIndices[0x00];
        DWaterIndices[0x80] = DWaterIndices[0x00];
        
        
        // Three ground in corner
        DWaterIndices[0x0F] = DWaterIndices[0x0B];
        DWaterIndices[0x2B] = DWaterIndices[0x0B];
        DWaterIndices[0x2F] = DWaterIndices[0x0B];
        
        DWaterIndices[0x17] = DWaterIndices[0x16];
        DWaterIndices[0x96] = DWaterIndices[0x16];
        DWaterIndices[0x97] = DWaterIndices[0x16];
        
        DWaterIndices[0x69] = DWaterIndices[0x68];
        DWaterIndices[0xE8] = DWaterIndices[0x68];
        DWaterIndices[0xE9] = DWaterIndices[0x68];
        
        DWaterIndices[0xD4] = DWaterIndices[0xD0];
        DWaterIndices[0xF0] = DWaterIndices[0xD0];
        DWaterIndices[0xF4] = DWaterIndices[0xD0];
        
        // Three ground straight
        DWaterIndices[0x3F] = DWaterIndices[0x1F];
        DWaterIndices[0x9F] = DWaterIndices[0x1F];
        
        DWaterIndices[0x6F] = DWaterIndices[0x6B];
        DWaterIndices[0xEB] = DWaterIndices[0x6B];
        
        DWaterIndices[0xD7] = DWaterIndices[0xD6];
        DWaterIndices[0xF6] = DWaterIndices[0xD6];
        
        DWaterIndices[0xF9] = DWaterIndices[0xF8];
        DWaterIndices[0xFC] = DWaterIndices[0xF8];
        
        MakeHammingSet(0x25, hammingset: &Hamming)
        for Value in Hamming{
            if -1 == DRockIndices[0x0A | Value]{
                DRockIndices[0x0A | Value] = DRockIndices[0x0B]
            }
        }
        
        MakeHammingSet(0x85, hammingset: &Hamming)
        for Value in Hamming{
            if -1 == DRockIndices[0x12 | Value]{
                DRockIndices[0x12 | Value] = DRockIndices[0x16]
            }
        }
        
        MakeHammingSet(0xA1, hammingset: &Hamming)
        for Value in Hamming{
            if -1 == DRockIndices[0x48 | Value]{
                DRockIndices[0x48 | Value] = DRockIndices[0x68]
            }
        }
        
        MakeHammingSet(0xA4, hammingset: &Hamming)
        for Value in Hamming{
            if -1 == DRockIndices[0x50 | Value]{
                DRockIndices[0x50 | Value] = DRockIndices[0xD0]
            }
        }
        
        // Three rocks straight
        DRockIndices[0x1B] = DRockIndices[0x1F];
        DRockIndices[0x1E] = DRockIndices[0x1F];
        DRockIndices[0x3F] = DRockIndices[0x1F];
        DRockIndices[0x9F] = DRockIndices[0x1F];
        
        DRockIndices[0x6F] = DRockIndices[0x6B];
        DRockIndices[0xEB] = DRockIndices[0x6B];
        
        DRockIndices[0xD7] = DRockIndices[0xD6];
        DRockIndices[0xF6] = DRockIndices[0xD6];
        
        DRockIndices[0x78] = DRockIndices[0xF8];
        DRockIndices[0xD8] = DRockIndices[0xF8];
        DRockIndices[0xF9] = DRockIndices[0xF8];
        DRockIndices[0xFC] = DRockIndices[0xF8];
        
        // Ends
        DRockIndices[0x09] = DRockIndices[0x08];
        DRockIndices[0x28] = DRockIndices[0x08];
        DRockIndices[0x29] = DRockIndices[0x08];
        
        DRockIndices[0x14] = DRockIndices[0x10];
        DRockIndices[0x90] = DRockIndices[0x10];
        DRockIndices[0x94] = DRockIndices[0x10];
        
        MakeHammingSet(0xA5, hammingset: &Hamming)
        for Value in Hamming{
            if -1 == DRockIndices[Value]{
                DRockIndices[Value] = DRockIndices[0x02]
            }
        }

        
        
    }
    
    
    func MakeHammingSet( value: Int, inout hammingset: [Int]){
        var BitCount:Int, Anchor:Int , LastEnd:Int
        hammingset = [Int]()
        for Index in 0..<8{
            let Value = 1 << Index;
            if value & Value > 0 {
                hammingset.append(Value)
            }
        }
        
        LastEnd = hammingset.count
        BitCount = hammingset.count
        Anchor = 0
        
        for _ in 1..<BitCount{
            for LastIndex in Anchor..<LastEnd{
                for BitIndex in 0..<BitCount{
                    let NewValue = hammingset[LastIndex] | hammingset[BitIndex]
                    if NewValue != hammingset[LastIndex]{
                        var Found = false
                        for Index in LastEnd..<hammingset.count{
                            if NewValue == hammingset[Index]{
                                Found = true;
                                break;
                            }
                        }
                        
                        if(Found == false){
                            hammingset.append(NewValue)
                        }
                    }
                }
            }
            Anchor = LastEnd + 1
            LastEnd = hammingset.count
        }
    }
    
    func VectorFiller(inout arrayFiller: [Int], prefix: String){
        for i in 0..<256{
            let tileTypeStr = prefix + String(i)
            let result = DMappingTiff[tileTypeStr]
            if result != nil{
                //print("rahil")
                arrayFiller.append(result!)
            }
            else{
                arrayFiller.append(-1)
            }
        }
    }

    func RetrieveFromDat(){
        let fileName = "Terrain.dat"
        let terrainDat = FileManager.returnDatFileContents(fileName)
        let terrainDatContent = terrainDat!.componentsSeparatedByString("\n")
        //let terrainPngPath = terrainDatContent[0]
        let numberOfTerrainTiles = Int(terrainDatContent[1])
        for i in 2 ..< (numberOfTerrainTiles! + 2){
            let name = terrainDatContent[i]
            DMappingTiff[name] = i
            print (DMappingTiff[name])
            //print ("tiffany")
        }
    }
    
    func GrabMapContent(){
        let fileName = "2player.map"
        let mapContent = FileManager.returnDatFileContents(fileName, subdirectory: "map")
        let mapInfo = mapContent!.componentsSeparatedByString("\n")
        //Map = mapInfo.filter{ (str: String) -> Bool in
        //    return str.characters.count > 20
        //}
        Map = mapInfo
    }
    
    func getTileType(x: Int, y: Int, curTile: String) ->Int{
        if curTile == "F"{
            var TreeIndex = 0, TreeMask = 0x1, UnknownMask = 0, DisplayIndex = -1
            print(curTile)
            for XOff in 0 ..< 2{
                for YOff in -1 ..< 2 {
                    var tempTile:String
                    var mapLine = Array(Map[y + YOff].characters)
                    //print(tempTile.endIndex)
                    //print("FCUKKD")
                    //print(y + YOff)
                    let nextTile = mapLine[x + XOff]
                    if String(nextTile) == "F"{
                        TreeIndex |= TreeMask
                    }
                    else if String(nextTile) == "asdf"{
                    //fog shit
                    }
                    TreeMask <<= 1
                }
            }
            if -1 == DTreeIndices[TreeIndex]{
                //fog shit
            }
            else{
                DisplayIndex = DTreeIndices[TreeIndex]
            }
            if(-1 != DisplayIndex){
                print(DisplayIndex)
                return DisplayIndex
            }
        }
        else if curTile == " "{
            var WaterIndex = 0, WaterMask = 0x1, UnknownMask = 0, DisplayIndex = -1
            print(curTile)
            for XOff in -1 ..< 2{
                for YOff in -1 ..< 2 {
                    if YOff != 0 && XOff != 0 {
                        var tempTile:String
                        var mapLine = Array(Map[y + YOff].characters)
                        //print(tempTile.endIndex)
                        //print("FCUKKD")
                        //print(y + YOff)
                        let nextTile = mapLine[x + XOff]
                        if String(nextTile) == " "{
                            WaterIndex |= WaterMask
                        }
                        else if String(nextTile) == "asdf"{
                            //fog shit
                        }
                        WaterMask <<= 1
                    }
                }
            }
            if -1 == DWaterIndices[WaterIndex]{
                //fog shit
            }
            else{
                DisplayIndex = DWaterIndices[WaterIndex]
            }
            if(-1 != DisplayIndex){
                print(DisplayIndex)
                return DisplayIndex
            }
        }
        else if curTile == "G"{
            var OtherIndex = 0, OtherMask = 0x1, UnknownMask = 0, DisplayIndex = -1
            print(curTile)
            for XOff in -1 ..< 2{
                for YOff in -1 ..< 2 {
                    if YOff != 0 && XOff != 0{
                        var tempTile:String
                        var mapLine = Array(Map[y + YOff].characters)
                        //print(tempTile.endIndex)
                        //print("FCUKKD")
                        //print(y + YOff)
                        let nextTile = mapLine[x + XOff]
                        if String(nextTile) == " " || String(nextTile) == "D" || String(nextTile) == "R"  {
                            OtherIndex |= OtherMask
                        }
                        else if String(nextTile) == "asdf"{
                            //fog shit
                        }
                        OtherMask <<= 1
                    }
                }
            }//fog i think V
//            if OtherIndex {
//                if -1 == DDirtIndices[OtherIndex]{
//                    //fog shit
//                }
//            }
//            if -1 == DIndices[WaterIndex]{
//                //fog shit
//            }
//            else{
//                DisplayIndex = DWaterIndices[WaterIndex]
//            }
//            if(-1 != DisplayIndex){
//                print(DisplayIndex)
//                return DisplayIndex
//            }
        }
        else if curTile == "R" {
            var RockIndex = 0, RockMask = 0x1, UnknownMask = 0, DisplayIndex = -1
            for XOff in -1 ..< 2{
                for YOff in -1 ..< 2{
                    if YOff != 0 && XOff != 0{
                        var tempTile:String
                        var mapLine = Array(Map[y + YOff].characters)
                        let nextTile = mapLine[x + XOff]
                        if String(nextTile) == "R"{
                            RockIndex |= RockMask
                        }
                        else if String(nextTile) == "asdf"{
                            //fog shit
                        }
                        RockMask <<= 1;
                    }
                }
            }
            if -1 == DTreeIndices[RockIndex]{
                //fog shit
            }
            else{
                DisplayIndex = DTreeIndices[RockIndex]
            }
            if(-1 != DisplayIndex){
                print(DisplayIndex)
                return DisplayIndex
            }

            
        }
        
       let dummy = 1
        print(dummy)
        return dummy
    }
    
    
    
    
    
    func getIndex(xPos : Int, yPos : Int) -> Int {
        
        let tempTile:String = getChar(xPos, yPos: yPos)
        
        let tile = tempTile.startIndex.advancedBy(xPos)
        var bitIndex : Int = 0
        var bitMask : Int = 1
        
        // account for tree depending on two rows, not three
        let startY : Int = String(tile) == "F" ? 0 : -1
        
        for yOff in startY ... 1 {
            for xOff in -1 ... 1 {
                if yOff != 0 && xOff != 0 {
                   // let ch:String = Map[1]
                    
//                    let text = "abc"
//                    let index2 = ch.startIndex.advancedBy(xPos) //will call succ 2 times
//                    let lastChar: Character = text[index2] //now we can index!
                  //  let lastChar = text.characters[index2] //will do the same

                    let temp:String = getChar(xPos + xOff, yPos: yPos + 1 + yOff)
                    let currentTile = temp.startIndex.advancedBy(xPos + xOff)
                    
                    
                    if tile == currentTile{
                        bitIndex |= bitMask
                    }
                    
                    bitMask <<= 1
                }
                
            }
        }
        
        switch String(tile) {
        case "G":
            return DGrassIndices[bitIndex]
        case "F":
            return DTreeIndices[bitIndex]
        case "D":
            return DDirtIndices[bitIndex]
        case "W":
            return DWallIndices[bitIndex]
        case "w":
            return DWallDamagedIndices[bitIndex]
        case "R":
            return DRockIndices[bitIndex]
        case " ":
            return DWaterIndices[bitIndex]
        default:
            break
        }
        
        return -1
    }
 
    
    func getChar(xPos: Int, yPos: Int) -> String {
        return Map[yPos]
    }

}





