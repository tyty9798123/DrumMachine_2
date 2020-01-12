//
//  PBAudioPlayer.swift
//  DrumMachine
//
//  Created by Swift on 2019/12/17.
//  Copyright © 2019 Swift. All rights reserved.
//

import UIKit
import AVFoundation

let WAV = "wav"
let NUMBERS_OF_CHANNEL = 16

enum DrumVoiceType : String {
    case none = "None"
    case bassDrum = "BassDrum"
    case snare = "Snare"
    case hiHatsClose = "HiHatsClose"
    case ride = "Ride"
    case highTom = "HighTom"
    case floorTom = "FloorTom"
    case crash = "Crash"
}

class PBDrumVoicePlayer: NSObject {

    var players : [AVAudioPlayer] = []
    
    var isPlaying : Bool {
        for player in self.players {
            if player.isPlaying {
                return true
            }
        }
        
        return false
    }
    
    var isSet : Bool {
        return self.players.count == NUMBERS_OF_CHANNEL
    }
    
    var voiceType: DrumVoiceType = .none {
        didSet {            
            if (oldValue != self.voiceType) {
                if let url = Bundle.main.url(forResource: self.voiceType.rawValue, withExtension: WAV) {
                    do {
                        let data = try Data(contentsOf: url)
                        
                        self.players.removeAll()
                        for _ in 1...NUMBERS_OF_CHANNEL {
                            let player = try AVAudioPlayer(data: data)
                            self.players.append(player)
                        }
                    } catch {
                        
                    }
                }
            }
        }
    }
    
    init(voiceType: DrumVoiceType) {
        
        super.init()
        
        defer {
            self.voiceType = voiceType
        }
    }
    
    func play(block : (() -> ())? = nil) {
        for player in self.players {
            if !player.isPlaying {
                player.play()
                break
            }
        }
        block?()
    }
    
    func stop(block : (() -> ())? = nil) {
        for player in self.players {
            if player.isPlaying {
                player.stop()
            }
        }
        block?()
    }
    
}
