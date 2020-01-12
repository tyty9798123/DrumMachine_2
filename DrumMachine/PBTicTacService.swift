//
//  PBTicTacService.swift
//  DrumMachine
//
//  Created by Swift on 2019/12/18.
//  Copyright © 2019 Swift. All rights reserved.
//

import UIKit

protocol PBTicTacServiceDelegate {
    func ticTacHandler(noteIndex: Int)
    func ticTacStart()
    func ticTacStop()
}

class PBTicTacService: NSObject {
    var bpm : Double = 60.0 {
        didSet {
            self.stop()
            self.start()
        }
    }
    
    var timer : Timer?
    
    var noteIndex : Int = 0
    
    private var _isRunning : Bool = false
    var isRunning : Bool {
        return _isRunning
    }
    
    
    var delegate : PBTicTacServiceDelegate?
    
    override init() {
        
        super.init()
        
        defer {

        }
    }
    
    func getSecondsFromBpm () -> TimeInterval {
        return Double(60.0) / (bpm * Double(4.0))
    }
    
    func start () {
        self.noteIndex = 0
        self.timer = Timer(timeInterval: self.getSecondsFromBpm(), repeats: true, block: { (timer) in
            self.delegate?.ticTacHandler(noteIndex: self.noteIndex)
            self.noteIndex += 1
            if self.noteIndex == 16 {
                self.noteIndex = 0
            }
        })
        
        if let timer = self.timer {
            RunLoop.current.add(timer, forMode: .common)
            timer.fire()
            _isRunning = true
        }
        self.delegate?.ticTacStart()
    }
    
    func stop () {
        self.timer?.invalidate()
        _isRunning = false
        self.delegate?.ticTacStop()
    }
}
