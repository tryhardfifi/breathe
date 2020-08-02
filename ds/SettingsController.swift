//
//  SettingsController.swift
//  breathe
//
//  Created by filipeisho on 02/08/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class SettingsController: NSViewController {
    @IBOutlet var Apply: NSButton!
  
    @IBAction func applyWasPressed(_ sender: Any) {
        print(sender)
    }
    @IBAction func HoldingWasUpdated(_ sender: NSSlider) {
        print(sender.integerValue)
    }
    @IBAction func BreathingInWasUpdated(_ sender: NSSlider) {
        print(sender.integerValue)

    }
    @IBAction func BreathingOutWasUpdated(_ sender: NSSlider) {
        print(sender.integerValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
   
}
