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

    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    @IBAction func launchWindowMenuItem(_ sender: NSMenuItem) {
        self.launchWindow()
    }
    @IBAction func preferencesMenuItem(_ sender: NSMenuItem) {
        self.preferences()
    }
    @IBAction func aboutBreatheMenuItem(_ sender: NSMenuItem) {
        self.about()

    }
    
    @IBAction func quitMenuItem(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
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
    
    func readRealPropertyList()  -> [String:Any] {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        var plistData: [String:Any] = [:] //Our data
        let plistPath = applicationDocumentsDirectory().appending("/exercises.plist")
        let plistXML = FileManager.default.contents(atPath: plistPath)!
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
        //statusItem.button?.action = #selector(showSettings)
        let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
        if !FileManager.default.fileExists(atPath: filepath) {
            var a = self.readPropertyList() as! NSDictionary
            a.write(toFile: filepath, atomically: true)
        }
        statusItem.menu = statusMenu
    }
    
    
    func applicationWillTerminate(_ aNotification: Notification) {
    }
     
    @objc func launchWindow(){
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
        var a = self.readRealPropertyList() as! NSDictionary
        let anchor = a["anchor"] as! String
        print(anchor)
        switch anchor {
        case "Down + Left":
            vc.view.window?.setFrameOrigin(NSPoint(x:0,y:0))
        case "Up + Left":
            vc.view.window?.setFrameOrigin(NSPoint(x: 0,y:(NSScreen.main?.frame.height ?? 0)-200 ))
        case "Down + Right":
            vc.view.window?.setFrameOrigin(NSPoint(x: (NSScreen.main?.frame.width ?? 0)-200 ?? 0,y:0))
        case "Up + Right":
            vc.view.window?.setFrameOrigin(NSPoint(x: (NSScreen.main?.frame.width ?? 0)-200 ?? 0,y:(NSScreen.main?.frame.height ?? 0)-200 ))
        default:
            vc.view.window?.setFrameOrigin(NSPoint(x:0,y:0))
        }
  
    }
    @objc func preferences(){
           let storyboard = NSStoryboard(name: "Main", bundle: nil)
           guard let vc = storyboard.instantiateController(withIdentifier: "SettingsController") as? SettingsController else {
               fatalError("Unable to find ViewController in the storyboard")
           }
           vc.presentAsModalWindow(vc)
           vc.view.window?.title = "breathe 💨 preferences"
           vc.view.window?.titlebarAppearsTransparent = true
           vc.view.window?.styleMask.remove(.resizable)
           vc.view.window?.isOpaque = false
           vc.view.window?.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
           vc.view.window?.setFrameOrigin(NSPoint(x:0,y:0))
        
           var a = self.readRealPropertyList() as! NSDictionary
           let anchor = a["anchor"] as! String
           print(anchor)
           switch anchor {
           case "Down + Left":
               vc.view.window?.setFrameOrigin(NSPoint(x:0,y:0))
           case "Up + Left":
               vc.view.window?.setFrameOrigin(NSPoint(x: 0,y:(NSScreen.main?.frame.height ?? 0)-200 ))
           case "Down + Right":
               vc.view.window?.setFrameOrigin(NSPoint(x: (NSScreen.main?.frame.width ?? 0)-200 ?? 0,y:0))
           case "Up + Right":
               vc.view.window?.setFrameOrigin(NSPoint(x: (NSScreen.main?.frame.width ?? 0)-200 ?? 0,y:(NSScreen.main?.frame.height ?? 0)-200 ))
           default:
               vc.view.window?.setFrameOrigin(NSPoint(x:0,y:0))
           }
           

        
       }
    @objc func about(){
              let storyboard = NSStoryboard(name: "Main", bundle: nil)
              guard let vc = storyboard.instantiateController(withIdentifier: "AboutWindow") as? NSViewController else {
                  fatalError("Unable to find AboutWindow in the storyboard")
              }
              vc.presentAsModalWindow(vc)
              vc.view.window?.title = "about breathe 💨"
              vc.view.window?.titlebarAppearsTransparent = true
              vc.view.window?.styleMask.remove(.resizable)
              vc.view.window?.isOpaque = false
              vc.view.window?.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
              vc.view.window?.setFrameOrigin(NSPoint(x:((NSScreen.main?.frame.width ?? 0)/2) - 200,y:((NSScreen.main?.frame.height ?? 0)/2) - 200))
          }
   
}

