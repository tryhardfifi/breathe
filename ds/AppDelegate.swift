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
   
    
    func readPropertyList()  -> [String:Any] {
           var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
           var plistData: [String:Any] = [:] //Our data
           let plistPath: String? = Bundle.main.path(forResource: "Exercises", ofType: "plist")!
           let plistXML = FileManager.default.contents(atPath: plistPath!)!
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

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    
        let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
        if !FileManager.default.fileExists(atPath: filepath) {
            let a = self.readPropertyList() as NSDictionary
            a.write(toFile: filepath, atomically: true)
       }

    }

  
   
}

