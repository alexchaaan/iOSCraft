//
//  Tile.swift
//  DavisCraft
//
//  Created by Andrew Tran on 10/12/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit


class Tile: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        let tile = MapRender(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        view.addSubview(tile)*/
        
        
        
        //add a Subview that is the size of the screen
        //works for different devices
        
        let (_, height, width ) = MapRender().readMap()
        let screen = MapRender(frame: CGRectMake(0, 0, CGFloat(width * 32), CGFloat(height * 32)))
        //view.addSubview(screen)
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = screen.bounds.size
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.addSubview(screen)
        view.addSubview(scrollView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}





