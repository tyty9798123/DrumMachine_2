//
//  IntroViewController.swift
//  DrumMachine
//
//  Created by Swift on 2019/12/16.
//  Copyright © 2019 Swift. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    var segueTimer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.runTimerForSegue()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.stopSegueTimer()
    }

    func runTimerForSegue () {
        self.segueTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
                    
            self.performSegue(withIdentifier: "infoToMain", sender: nil)
        }
    }
    
    func stopSegueTimer () {
        if let timer = self.segueTimer {
            timer.invalidate()
        }
    }

}
