//
//  NewExerciseController.swift
//  breathe
//
//  Created by filipeisho on 05/08/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class NewExerciseController: NSViewController {
    @IBOutlet var PopOver: NSView!
    @IBOutlet weak var breathingInLabel: NSTextField!
    @IBOutlet weak var firstHoldingLabel: NSTextField!
    @IBOutlet weak var breathingOutLabel: NSTextField!
    @IBOutlet weak var secondHoldingLabel: NSTextField!
    weak var delegate: SettingsController!
    @IBOutlet weak var exerciseName: NSTextField!
    
    @IBAction func breathingInWasUpdated(_ sender: NSStepper) {
         breathingInLabel.stringValue = String(sender.integerValue)
    }
    @IBAction func firstHoldingWasUpdated(_ sender: NSStepper) {
           firstHoldingLabel.stringValue = String(sender.integerValue)
       }
    @IBAction func breathingOutWasUpdated(_ sender: NSStepper) {
        breathingOutLabel.stringValue = String(sender.integerValue)
    }
    
    @IBAction func secondHoldingWasUpdated(_ sender: NSStepper) {
        secondHoldingLabel.stringValue = String(sender.integerValue)
    }
    @IBAction func createWasPressed(_ sender: NSButton) {
        let propertyList = self.readPropertyList() as NSMutableDictionary
        let exercises = propertyList["exercises"] as! NSMutableDictionary
        let new_exercise = ["inflate": breathingInLabel.intValue,"deflate": breathingOutLabel.intValue, "hold_after_inflate": firstHoldingLabel.intValue, "hold_after_deflate": secondHoldingLabel.intValue]
        exercises[exerciseName.stringValue] = new_exercise
        propertyList["inflate"] = breathingInLabel.intValue
        propertyList["deflate"] = breathingOutLabel.intValue
        propertyList["hold_after_inflate"] = firstHoldingLabel.intValue
        propertyList["hold_after_deflate"] = secondHoldingLabel.intValue
        propertyList["exercises"] = exercises
        let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
        propertyList.write(toFile: filepath, atomically: true)
        self.delegate.viewDidLoad()
        self.delegate.exerciseSelector.selectItem(withTitle: exerciseName.stringValue as! String)
        self.view.window?.performClose(sender)
        self.view.window?.close()

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
        
    }
}
