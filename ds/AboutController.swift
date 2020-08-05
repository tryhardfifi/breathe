//
//  AboutController.swift
//  breathe
//
//  Created by filipeisho on 05/08/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class AboutController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    override func viewDidAppear() {
          super.viewDidAppear()
          self.view.window?.level = .floating
           self.view.window?.title = "about breathe 💨"
           self.view.window?.titlebarAppearsTransparent = true
           self.view.window?.styleMask.remove(.resizable)
           self.view.window?.isOpaque = false
           self.view.window?.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
           self.view.window?.setFrameOrigin(NSPoint(x:((NSScreen.main?.frame.width ?? 0)/2) - 200,y:((NSScreen.main?.frame.height ?? 0)/2) - 200))

      }
    
}
