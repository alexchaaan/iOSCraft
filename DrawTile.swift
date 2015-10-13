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
        let image = UIImage(named: "Farm.png")
        let h = image!.size.height
        let w = image!.size.width
        //number of tiles that we can get from the .dat file later
        let numberOfTiles = 4;
        //index is the number of the specific tile we want
        let index = 2
        let tile = CGImageCreateWithImageInRect(image?.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles))), w, h/CGFloat(numberOfTiles)))
        
        //we can use CGPointMake to draw the images to specific location on our map
        //So we can draw it in the middle or on the right or whereever we need
        let location = CGPointMake(100 , 100)
        //image?.drawAtPoint(location)
        UIImage(CGImage: tile!).drawAtPoint(location)
    }

}
