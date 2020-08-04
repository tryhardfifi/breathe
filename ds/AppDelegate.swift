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
    func readPropertyList()  -> [String:Any] {
           var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
           var plistData: [String:Any] = [:] //Our data
           let plistPath: String? = Bundle.main.path(forResource: "Exercises", ofType: "plist")! //the path of the data
           let plistXML = FileManager.default.contents(atPath: plistPath!)!
               do {//convert the data to a dictionary and handle errors.
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

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.title = "💨"
        statusItem.button?.target = self
        statusItem.button?.action = #selector(showSettings)
        let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
        if !FileManager.default.fileExists(atPath: filepath) {
            var a = self.readPropertyList() as! NSDictionary
            a.write(toFile: filepath, atomically: true)
        }
    }
    
    
    func applicationWillTerminate(_ aNotification: Notification) {
    }
     
    @objc func showSettings(){
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "ViewController") as? ViewController else {
            fatalError("Unable to find ViewController in the storyboard")
        }
        vc.presentAsModalWindow(vc)
        vc.view.window?.title = "breathe💨"
        vc.view.window?.titlebarAppearsTransparent = true
        vc.view.window?.styleMask.remove(.resizable)
        //vc.view.window?.titleVisibility = .hidden
        vc.view.window?.styleMask.insert(.fullSizeContentView)
        vc.view.window?.isOpaque = false
        vc.view.window?.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
        vc.view.window?.setFrameOrigin(NSPoint(x:0,y:0))
    }

}

