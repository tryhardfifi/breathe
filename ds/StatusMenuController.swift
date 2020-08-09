//
//  StatusMenuController.swift
//  breathe
//
//  Created by filipeisho on 05/08/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject, NSMenuDelegate {
    
    

    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var storyBoard = NSStoryboard.init()
       

    @IBAction func quitWasPressed(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    func readRealPropertyList()  -> [String:Any] {
            var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
            var plistData: [String:Any] = [:]
            let plistPath = applicationDocumentsDirectory().appending("/exercises.plist")
            let plistXML = FileManager.default.contents(atPath: plistPath)!
            do {
                plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:Any]
                
            } catch {
                print("Error reading plist: \(error), format: \(propertyListFormat)")
            }
            return plistData
        }
    

    
    func applicationDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let basePath = paths.first ?? ""
        return basePath
    }

    override func awakeFromNib() {
       self.storyBoard = NSStoryboard(name: "Main", bundle: nil)
       statusItem.button?.title = "💨"
       statusItem.button?.target = self
       statusItem.button?.target = self
       statusItem.button?.action = #selector(showSettings)
    }
      
      
      func applicationWillTerminate(_ aNotification: Notification) {
          // Insert code here to tear down your application
      }
      
      @objc func showSettings(){
        for i in 0...NSApplication.shared.windows.count-1{
            if NSApplication.shared.windows[i].title == "breathe💨"{
                NSApplication.shared.windows[i].performClose(self)
            }
        }
            

                    
          let storyboard = NSStoryboard(name: "Main", bundle: nil)
          guard let vc = storyboard.instantiateController(withIdentifier: "SettingsController") as? SettingsController else {
              fatalError("Unable to find SettingsController in the storyboard")
          }
          guard let button = statusItem.button else {
              fatalError("Unable to get button")
          }
          let popoverView = NSPopover()
          popoverView.contentViewController = vc
          popoverView.behavior = .transient
          let rect = NSRect(x: -20, y: 0, width: 100, height: 100)
          popoverView.show(relativeTo: button.bounds, of: button, preferredEdge: .maxY)

      }
    

    }



