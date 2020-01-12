//
//  MainViewController.swift
//  DrumMachine
//
//  Created by Swift on 2019/12/16.
//  Copyright © 2019 Swift. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, PBTicTacServiceDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var showVoiceTypePickerButton: UIButton!
    
    @IBOutlet weak var voiceTypePickerViewBlockingView: UIView!
    
    @IBOutlet weak var playButton: UIButton!
        
    @IBOutlet weak var voiceTypePickerView: UIPickerView!
    
    var voiceTypePlayers = [
        PBDrumVoicePlayer(voiceType: .hiHatsClose),
        PBDrumVoicePlayer(voiceType: .bassDrum),
        PBDrumVoicePlayer(voiceType: .snare),
        PBDrumVoicePlayer(voiceType: .ride),
        PBDrumVoicePlayer(voiceType: .highTom),
        PBDrumVoicePlayer(voiceType: .floorTom),
        PBDrumVoicePlayer(voiceType: .crash),
    ]
    
    var currentEditingPlayer :PBDrumVoicePlayer? {
        didSet {
            self.showVoiceTypePickerButton.setTitle(self.currentEditingPlayer?.voiceType.rawValue, for: .normal)

        }
    }
    
    var ticTacService = PBTicTacService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ticTacService.delegate = self
        
        self.voiceTypePickerView.delegate = self
        self.voiceTypePickerView.dataSource = self
        
        self.currentEditingPlayer = voiceTypePlayers.first
        
        self.closeVoiceTypePicker(animating: false)
    }

    
    @IBAction func showVoiceTypePickerButtonClicked(_ sender: UIButton) {
        self.showVoiceTypePicker()
    }
    
    @IBAction func closeVoiceTypePickerButtonClicked(_ sender: UIButton) {
        self.closeVoiceTypePicker()
    }
    
    func showVoiceTypePicker(animating: Bool = true) {
        
        if let player = self.currentEditingPlayer, let index = self.voiceTypePlayers.firstIndex(of: player) {
            
            self.voiceTypePickerView.selectRow(index, inComponent: 0, animated: false)
        }

        if animating {
            UIView.animate(withDuration: 0.3) {
                self.voiceTypePickerViewBlockingView.alpha = 1
            }
        } else{
            self.voiceTypePickerViewBlockingView.alpha = 1
        }
    }
    
    func closeVoiceTypePicker(animating: Bool = true) {
        if animating {
            UIView.animate(withDuration: 0.3) {
                self.voiceTypePickerViewBlockingView.alpha = 0
            }
        } else {
            self.voiceTypePickerViewBlockingView.alpha = 0
        }
    }
    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        
        if !self.ticTacService.isRunning {
            self.ticTacService.start()
        } else {
            self.ticTacService.stop()
        }
        
//        guard self.player.isSet else {
//            print("Error player is not set")
//            return
//        }
//
//        if !self.player.isPlaying {
//            self.player.play {
//                self.playButton.setBackgroundImage(UIImage(systemName: "stop.fill"), for: .normal)
//            }
//        }else{
//            self.player.stop {
//                self.playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
//            }
//        }
    }
    

    @IBAction func voiceTypeSelectedButtonClicked(_ sender: UIButton) {
        let rowNumber = self.voiceTypePickerView.selectedRow(inComponent: 0)
        
        if rowNumber < self.voiceTypePlayers.count {
            self.currentEditingPlayer = self.voiceTypePlayers[rowNumber]
        }
        self.closeVoiceTypePicker()
    }
    
    @IBAction func voiceTypeCancelButtonClicked(_ sender: UIButton) {
        self.closeVoiceTypePicker()
    }
    

    func ticTacHandler (noteIndex: Int) {
        print("ticTacHandler \(noteIndex)")
        
//        currentEditingPlayer.play()
    }
    
    func ticTacStart() {
        self.playButton.setBackgroundImage(UIImage(systemName: "stop.fill"), for: .normal)
    }
    
    func ticTacStop() {
        self.playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.voiceTypePlayers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.voiceTypePlayers[row].voiceType.rawValue
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showVoiceEditingPage" {
            print("showVoiceEditingPage !!")
            if let controller = segue.destination as? SettingsViewController {
                
                controller.currentEditingPlayer = self.currentEditingPlayer
            }
        }
    }
}

