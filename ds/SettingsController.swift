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
    
  
   
    
   
    @IBAction func selectWasPressed(_ sender: Any) {
        var a = self.readPropertyList() as NSMutableDictionary
        var selectedItem = exerciseSelector.titleOfSelectedItem!
        var b = a["exercises"] as! NSMutableDictionary
        var c = b[selectedItem] as! NSMutableDictionary
        a["inflate"] = c["inflate"]
        a["deflate"] = c["deflate"]
        a["hold_after_inflate"] = c["hold_after_inflate"]
        a["hold_after_deflate"] = c["hold_after_deflate"]
        let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
        a.write(toFile: filepath, atomically: true)

        
        self.view.window?.close()
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
