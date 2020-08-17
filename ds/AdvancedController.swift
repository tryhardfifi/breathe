//
//  AdvancedController.swift
//  breathe
//
//  Created by filipeisho on 10/08/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class AdvancedController: NSViewController {
    @IBOutlet weak var durationLabel: NSTextField!
    @IBOutlet weak var progressionEnabled: NSButton!
    @IBOutlet weak var increaseByStepper: NSStepper!
    @IBOutlet weak var minutesStepper: NSStepper!
    @IBOutlet weak var timesStepper: NSStepper!
    @IBOutlet weak var increaseByLabel: NSTextField!
    @IBOutlet weak var minutesLabel: NSTextField!
    @IBOutlet weak var timesLabel: NSTextField!
     
      
    @IBAction func progressionEnabled(_ sender: NSButton) {
         
         self.updateProgressionValues()
     }

     @IBAction func closeWasPressed(_ sender: Any) {
         self.view.window?.close()
     }
     @IBAction func increaseByWasUpdated(_ sender: NSStepper) {
         increaseByLabel.stringValue = String(sender.doubleValue*0.1)
         self.updateProgressionValues()
         
     }
     @IBAction func minutesWasUpdated(_ sender: NSStepper) {
           minutesLabel.stringValue = String(sender.integerValue)
         self.updateProgressionValues()

     }
     @IBAction func timesWasUpdated(_ sender: NSStepper) {
           timesLabel.stringValue = String(sender.integerValue)
         self.updateProgressionValues()
     }
     
     
     func updateProgressionValues(){
         if self.progressionEnabled.state.rawValue == 1 {
           increaseByStepper.isEnabled = true
           minutesStepper.isEnabled = true
           timesStepper.isEnabled = true
           durationLabel.intValue = (timesLabel.intValue * minutesLabel.intValue)

         
         }
         else {
             increaseByStepper.isEnabled = false
             minutesStepper.isEnabled = false
             timesStepper.isEnabled = false
             durationLabel.intValue = 0
         }
         let propertyList = self.readPropertyList()
         propertyList["progression_enabled"] = self.progressionEnabled.state.rawValue
         propertyList["progression_increase_by"] = self.increaseByLabel.doubleValue
         propertyList["progression_minutes"] = self.minutesLabel.intValue
         propertyList["progression_times"] = self.timesLabel.intValue
         let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
         propertyList.write(toFile: filepath, atomically: true)
     }
     
     
 
   func applicationDocumentsDirectory() -> String {
   let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let basePath = paths.first ?? ""
        return basePath
    }
    func readPropertyList()  -> NSMutableDictionary {
          var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
          var plistData: NSMutableDictionary = [:] //Our data
          let plistPath = applicationDocumentsDirectory().appending("/exercises.plist")
          let plistXML = FileManager.default.contents(atPath: plistPath)!
              do {//convert the data to a dictionary and handle errors.
              plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! NSMutableDictionary
              
          } catch {
              print("Error reading plist: \(error), format: \(propertyListFormat)")
          }
          return plistData
      }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let propertyList = self.readPropertyList()
        self.progressionEnabled.intValue = propertyList["progression_enabled"] as! Int32
        self.increaseByLabel.intValue = propertyList["progression_increase_by"] as! Int32
        self.increaseByLabel.stringValue = String((propertyList["progression_increase_by"] as! Double)*0.1)
        self.minutesLabel.intValue = propertyList["progression_minutes"] as! Int32
        self.timesLabel.intValue = propertyList["progression_times"] as! Int32
        self.increaseByStepper.intValue = propertyList["progression_increase_by"] as! Int32
        self.minutesStepper.intValue = propertyList["progression_minutes"] as! Int32
        self.timesStepper.intValue = propertyList["progression_times"] as! Int32
        if self.progressionEnabled.state.rawValue == 1 {
          self.durationLabel.intValue = self.timesLabel.intValue * self.minutesLabel.intValue

          increaseByStepper.isEnabled = true
          minutesStepper.isEnabled = true
          timesStepper.isEnabled = true
        }
        
      
        //self.updateBreathingConstants(exerciseTitle: propertyList["exercise"] as! String)
        // Do view setup here.
    }
    
}
