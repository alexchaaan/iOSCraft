//
//  DrawTile.swift
//  DavisCraft
//
//  Created by Andrew Tran on 10/12/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit

class DrawTile: UIView {

    override func drawRect(rect: CGRect) {
        //let context = UIGraphicsGetCurrentContext()
       
        //reads dat file
        let fileName = "Farm"
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "dat")
        let content = try! String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        
        //stores each line of dat file in an index of array
        let contentArray = content.componentsSeparatedByString("\n")
        //contentArray[0] holds the png image's path
        //contentArray[1] holds the amount of tiles in image
        
        let image = UIImage(named: "Farm.png")
        let h = image!.size.height
        let w = image!.size.width
        
        //number of tiles that we got from the .dat file
        let numberOfTiles = Int(contentArray[1]);
        //index is the number of the specific tile we want
        let index = 4
        let tile = CGImageCreateWithImageInRect(image?.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles!))), w, h/CGFloat(numberOfTiles!)))
        
        //we can use CGPointMake to draw the images to specific location on our map
        //So we can draw it in the middle or on the right or whereever we need
        let location = CGPointMake(100 , 100)
        //image?.drawAtPoint(location)
        UIImage(CGImage: tile!).drawAtPoint(location)
    }

}
//still need to be able to grab png from the location given from .dat
//need a way to store the tiles with the name given in .dat
//need to add a throw for the let content = try! line



