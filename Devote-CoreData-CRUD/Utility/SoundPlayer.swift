//
//  SoundPlayer.swift
//  Devote-CoreData-CRUD
//
//  Created by Drashti on 20/12/23.
//

import Foundation
import AVFoundation

var audioPlyer: AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
            audioPlyer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioPlyer?.play()
        }
        catch {
            print("Could not find and play the sound file.")
        }
    }
}
