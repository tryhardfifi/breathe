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
   
    
      func readRealPropertyList()  -> [String:Any] {
          var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
          var plistData: [String:Any] = [:] //Our data
          let plistPath = applicationDocumentsDirectory().appending("/exercises.plist")
        print(plistPath)
          let plistXML = FileManager.default.contents(atPath: plistPath)!
              do {//convert the data to a dictionary and handle errors.
              plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:Any]
              
          } catch {
              print("Error reading plist: \(error), format: \(propertyListFormat)")
          }
          return plistData
      }
    
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
            let new_property_list = self.readPropertyList() as NSDictionary
            new_property_list.write(toFile: filepath, atomically: true)
        }
        else {
            let real_property_list = self.readRealPropertyList() as NSDictionary
            if real_property_list.allKeys.count != 14
            {
                let new_property_list = self.readPropertyList() as NSDictionary
                new_property_list.write(toFile: filepath, atomically: true)
            }
        }
          let storyboard = NSStoryboard(name: "Main", bundle: nil)
          guard let vc = storyboard.instantiateController(withIdentifier: "ViewController") as? ViewController else {
              fatalError("Unable to find ViewController in the storyboard")
          }
          vc.presentAsModalWindow(vc)
    }

  
   
}

