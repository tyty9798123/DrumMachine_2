//
//  SettingsViewController.swift
//  DrumMachine
//
//  Created by Swift on 2019/12/16.
//  Copyright © 2019 Swift. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var currentEditingPlayerNameLabel: UILabel!
    
    var currentEditingPlayer : PBDrumVoicePlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        currentEditingPlayerNameLabel.text = self.currentEditingPlayer?.voiceType.rawValue
    }
    
    @IBAction func dismissButtonClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            print("After Settings page dismiss")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
