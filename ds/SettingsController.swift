//
//  SettingsController.swift
//  breathe
//
//  Created by filipeisho on 02/08/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class SettingsController: NSViewController {

    
    @IBOutlet weak var breathingInLabel: NSTextField!
    @IBOutlet weak var firstHoldingLabel: NSTextField!
    @IBOutlet weak var breathingOutLabel: NSTextField!
    @IBOutlet weak var secondHoldingLabel: NSTextField!
    @IBOutlet weak var exerciseSelector: NSPopUpButton!
    @IBOutlet weak var exerciseName: NSTextField!
    
    @IBOutlet weak var anchorSelector: NSPopUpButton!
    
   
    @IBAction func anchorWasUpdated(_ sender: NSPopUpButton) {
        var a = self.readPropertyList() as NSMutableDictionary
        print(anchorSelector.stringValue)
        a["anchor"] = sender.selectedItem
        let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
        a.write(toFile: filepath, atomically: true)
        a = self.readPropertyList() as NSMutableDictionary


    }
    
    @IBAction func createWasPressed(_ sender: NSButton) {
         var a = self.readPropertyList() as NSMutableDictionary
         var b = a["exercises"] as! NSMutableDictionary
         var c = ["inflate": breathingInLabel.intValue,"deflate": breathingOutLabel.intValue, "hold_after_inflate": firstHoldingLabel.intValue, "hold_after_deflate": secondHoldingLabel.intValue]
        
         b[exerciseName.stringValue] = c
         a["exercises"] = b
         let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
         a.write(toFile: filepath, atomically: true)
         var keys = b as! [String:AnyObject]
         keys.keys.forEach() {self.exerciseSelector.addItem(withTitle: $0) }
    }
    
    @IBAction func deleteWasPressed(_ sender: Any) {
         var a = self.readPropertyList() as NSMutableDictionary
         var b = a["exercises"] as! NSMutableDictionary
        
        print(b)
        
        b.removeObject(forKey: exerciseSelector.stringValue)
        a["exercises"] = b
        print(b)
        let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
        a.write(toFile: filepath, atomically: true)
        
    }
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
        let a = self.readPropertyList()
        let b = a["exercises"] as! [String:AnyObject]
        b.keys.forEach() {self.exerciseSelector.addItem(withTitle: $0) }
      }
 
     
    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.level = .floating
       
    }
   
}
