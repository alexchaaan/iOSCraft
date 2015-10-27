//
//  GameScene.swift
//  DavisCraft
//
//  Created by Charlie on 10/2/15.
//  Copyright (c) 2015 UCDClassNitta. All rights reserved.
//

import SpriteKit
import AVFoundation

@available(iOS 8.0, *)
var backgroundMusicPlayer = AVMIDIPlayer()

func playBackgroundMusic(filename: String) {
    //Load the soundfont
    let soundFontURL = NSBundle.mainBundle().URLForResource("generalsoundfont",
        withExtension: "sf2",
        subdirectory: "data/snd")
    
    //Load the midi file
    let url = NSBundle.mainBundle().URLForResource(filename,
        withExtension: "mid",
        subdirectory: "data/snd/music")
    guard let midiURL = url else {
        print("Could not find file: \(filename)")
        return
    }
    
    do {
        if #available(iOS 8.0, *) {
            backgroundMusicPlayer = try AVMIDIPlayer(contentsOfURL: midiURL, soundBankURL: soundFontURL)
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play(nil)
        } else {
            print("I sure hope we don't support iOS 7.")
            // Fallback on earlier versions
        }
    } catch let error as NSError {
        print(error.description)
    }
}

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}