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
        let tile = CGImageCreateWithImageInRect(image?.CGImage, CGRectMake(0, h/2, w, h/4))
        //we can use CGPointMake to draw the images to specific location on map later
        let location = CGPointMake(100 , 100)
        //image?.drawAtPoint(location)
        UIImage(CGImage: tile!).drawAtPoint(location)
    }

}
