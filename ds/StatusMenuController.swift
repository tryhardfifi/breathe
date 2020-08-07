//
//  StatusMenuController.swift
//  breathe
//
//  Created by filipeisho on 05/08/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject, NSMenuDelegate {
    
    @IBOutlet weak var statusMenu: NSMenu!
    

    
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
       statusMenu.autoenablesItems = false
       statusItem.menu = statusMenu
        statusMenu.delegate = self
    }
   
        func menuWillOpen(_ menu: NSMenu) {

         

    }
  
    

    }



