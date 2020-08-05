//
//  SettingsController.swift
//  breathe
//
//  Created by filipeisho on 02/08/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class SettingsController: NSViewController {

    
    @IBOutlet weak var exerciseSelector: NSPopUpButton!
    @IBOutlet weak var anchorSelector: NSPopUpButton!
    var popoverView = NSPopover.init()

    @IBAction func NewExerciseWasPressed(_ sender: NSButton) {
        guard let vc = storyboard?.instantiateController(withIdentifier: "NewExerciseController") as? NewExerciseController else {
            fatalError("Unable to find NewExerciseController in the storyboard")
        }
        popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        popoverView.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
    }
    
    @IBAction func exerciseSelectorWasUpdated(_ sender: NSPopUpButton) {
       let propertyList = self.readPropertyList() as NSMutableDictionary
       let exercises = propertyList["exercises"] as! NSMutableDictionary
       let title = sender.selectedItem?.title
       let exercise = exercises[title] as! NSMutableDictionary
       propertyList["exercise"] = title
       propertyList["inflate"] = exercise["inflate"]
       propertyList["deflate"] = exercise["deflate"]
       propertyList["hold_after_inflate"] = exercise["hold_after_inflate"]
       propertyList["hold_after_deflate"] = exercise["hold_after_deflate"]
       let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
       propertyList.write(toFile: filepath, atomically: true)
    }
    
    @IBAction func anchorWasUpdated(_ sender: NSPopUpButton) {
        let propertyList = self.readPropertyList() as NSMutableDictionary
        propertyList["anchor"] = sender.selectedItem?.title
        let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
        propertyList.write(toFile: filepath, atomically: true)
    }
    
   
    
    @IBAction func deleteWasPressed(_ sender: Any) {
        let propertyList = self.readPropertyList() as NSMutableDictionary
        let exercises = propertyList["exercises"] as! NSMutableDictionary
        exercises.removeObject(forKey: exerciseSelector.selectedItem?.title)
        propertyList["exercises"] = exercises
        let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
        propertyList.write(toFile: filepath, atomically: true)
        let newExercises = propertyList["exercises"] as! [String:AnyObject]
        self.exerciseSelector.removeAllItems()
        newExercises.keys.forEach() {self.exerciseSelector.addItem(withTitle: $0) }
        
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
        let exercises = propertyList["exercises"] as! [String:AnyObject]
        exercises.keys.forEach() {self.exerciseSelector.addItem(withTitle: $0) }
        exerciseSelector.selectItem(withTitle: propertyList["exercise"] as! String)
    }
   
     
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.level = .floating
        self.view.window?.title = "breathe 💨 preferences"
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.styleMask.remove(.resizable)
        self.view.window?.isOpaque = false
        self.view.window?.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        self.view.window?.setFrameOrigin(NSPoint(x:0,y:0))
        let propertyList = self.readPropertyList() as NSDictionary
        let anchor = propertyList["anchor"] as! String
        self.view.window?.setFrameOrigin(NSPoint(x:((NSScreen.main?.frame.width ?? 0)/2) - 200,y:((NSScreen.main?.frame.height ?? 0)/2) - 200))
       
    }
   
}
