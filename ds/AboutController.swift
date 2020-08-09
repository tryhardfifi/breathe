//
//  AboutController.swift
//  breathe
//
//  Created by filipeisho on 05/08/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class AboutController: NSViewController {

    @IBAction func closeWasPressed(_ sender: NSButton) {
        self.view.window?.close()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear() {
          super.viewDidAppear()
          self.view.window?.level = .floating
           self.view.window?.title = "about breathe 💨"
           self.view.window?.titlebarAppearsTransparent = true
           self.view.window?.styleMask.remove(.resizable)
           self.view.window?.isOpaque = false
           self.view.window?.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
           self.view.window?.styleMask.remove(.titled)


      }
    
}
