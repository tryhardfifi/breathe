//
//  AppDelegate.swift
//  ds
//
//  Created by filipeisho on 31/07/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        // statusItem.button?.title = "breathe dude"
        
        statusItem.button?.title = "breathe"
        

        statusItem.button?.target = self
        statusItem.button?.action = #selector(showSettings)
        //let itemImage = NSImage(named: "clock")
       // itemImage?.isTemplate = true
        //statusItem.button?.image = itemImage

    }
    
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func showSettings(){
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "SettingsController") as? SettingsController else {
            fatalError("Unable to find SettingsController in the storyboard")
        }
        //guard let button = statusItem.button else {
        //    fatalError("Unable to get button")
        //}
        //let popoverView = NSPopover()
        //popoverView.contentViewController = vc
        //popoverView.behavior = .transient
        //let rect = NSRect(x: -20, y: 0, width: 100, height: 100)
        //popoverView.show(relativeTo: button.bounds, of: button, preferredEdge: .maxY)
        vc.presentAsModalWindow(vc)
        vc.view.window?.title = "breathe"
        vc.view.window?.setFrameOrigin(NSPoint(x:0,y:0))
    }

}

