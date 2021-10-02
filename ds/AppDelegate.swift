//
//  AppDelegate.swift
//  ds
//
//  Created by filipeisho on 31/07/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa
import ServiceManagement

extension Notification.Name {
    static let killLauncher = Notification.Name("killLauncher")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
      
    
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
        let allowed_apps = Set(NSWorkspace.shared.runningApplications)
        DispatchQueue.global(qos: .userInitiated).async {
            while true {
                sleep(2)
                let apps = Set(NSWorkspace.shared.runningApplications)
                print(Array(allowed_apps.symmetricDifference(apps)))
                   
            }
        }
            
        let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
        if !FileManager.default.fileExists(atPath: filepath) {
            let new_property_list = self.readPropertyList() as NSDictionary
            new_property_list.write(toFile: filepath, atomically: true)
        }
        else {
            let real_property_list = self.readRealPropertyList() as NSDictionary
            let property_list = self.readPropertyList() as NSDictionary

            if real_property_list.allKeys.count != property_list.allKeys.count
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
        
        let property_list = self.readRealPropertyList() as NSDictionary
        if property_list["open_at_login"] as! Int == 1 {
            let launcherAppId = "filipeisho.LauncherApplication"
            let runningApps = NSWorkspace.shared.runningApplications
            let isRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppId }.isEmpty
            SMLoginItemSetEnabled(launcherAppId as CFString, true)
            if isRunning {
                DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
            }
        }
        else {
            let launcherAppId = "filipeisho.LauncherApplication"
            let runningApps = NSWorkspace.shared.runningApplications
            let isRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppId }.isEmpty
            SMLoginItemSetEnabled(launcherAppId as CFString, false)
            if isRunning {
                DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
            }
        }
    }
    
   
}




    

