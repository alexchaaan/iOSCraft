//
//  AVAudioPlayerPool.swift
//  DavisCraft
//
//  Created by Michael Figueroa on 10/9/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import AVFoundation

private var playerPool : [AVAudioPlayer] = []

//Creates a pool of Audioplayer objects, reuses ones that are not playing otherwise creates a new one.
class AVAudioPlayerPool: NSObject {
    
    // Given the URL of a sound file, either create or reuse an audio player
    class func returnAVAudioPlayerWithFilenameAndSubdirectoryWithinSnd(filename: String, subdir: String) -> AVAudioPlayer? {
        
        let url = NSBundle.mainBundle().URLForResource(filename,
            withExtension: nil,
            subdirectory: "data/snd/" + subdir)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return nil
        }
        
        // Try to find a player that can be reused and is not playing
        let availablePlayers = playerPool.filter { (player) -> Bool in
            return player.playing == false && player.url == newURL
        }
        
        // If we found one, return it
        if let playerToUse = availablePlayers.first {
            return playerToUse
        }
        
        
        // Didn't find one? Create a new one
        var newPlayer:AVAudioPlayer?
        do{
            try newPlayer = AVAudioPlayer(contentsOfURL: newURL)
            playerPool.append(newPlayer!)
            
        }
        catch {
            // Couldn't create new audioplayer, return nil
            print("Couldn't load \(newURL.lastPathComponent)")
            return nil
        }
        return newPlayer!
    }
    
}