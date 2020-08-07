//
//  SettingsController.swift
//  breathe
//
//  Created by filipeisho on 02/08/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class SettingsController: NSViewController {
    @IBOutlet weak var breathingInColor: NSColorWell!
    @IBOutlet weak var firstHoldingColor: NSColorWell!
    @IBOutlet weak var breathingOutColor: NSColorWell!
    @IBOutlet weak var secondHoldingColor: NSColorWell!
    
    @IBOutlet weak var exerciseSelector: NSPopUpButton!
    @IBOutlet weak var anchorSelector: NSPopUpButton!
    var popoverView = NSPopover.init()
   
    
    @IBAction func breathingInColorWasUpdated(_ sender: NSColorWell) {
        self.set_color(string: "inflate_color", color: sender.color)
    }
    @IBAction func firstHoldingColorWasUpdated(_ sender: NSColorWell) {
        self.set_color(string: "hold_color", color: sender.color)
    }
    @IBAction func breathingOutColorWasUpdated(_ sender: NSColorWell) {
        self.set_color(string: "deflate_color", color: sender.color)
    }
  
    @IBAction func closeWasPressed(_ sender: Any) {
        self.view.window?.close()
    }
    
    func set_color(string:String,color:NSColor){
        let propertyList = self.readPropertyList() as NSMutableDictionary
        let colorArray = propertyList[string] as! NSMutableDictionary
        colorArray["red"] = color.redComponent
        colorArray["green"] = color.greenComponent
        colorArray["blue"] = color.blueComponent
        propertyList[string] = colorArray
        let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
        propertyList.write(toFile: filepath, atomically: true)
    }
    
    @IBAction func NewExerciseWasPressed(_ sender: NSButton) {
        guard let vc = storyboard?.instantiateController(withIdentifier: "NewExerciseController") as? NewExerciseController else {
            fatalError("Unable to find NewExerciseController in the storyboard")
        }
        vc.delegate = self
        popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        popoverView.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
    }
    
    @IBAction func exerciseSelectorWasUpdated(_ sender: NSPopUpButton) {
        self.updateBreathingConstants(exerciseTitle: sender.selectedItem?.title ?? "")
    }
    
    @IBAction func anchorWasUpdated(_ sender: NSPopUpButton) {
        let propertyList = self.readPropertyList() as NSMutableDictionary
        propertyList["anchor"] = sender.selectedItem?.title
        let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
        propertyList.write(toFile: filepath, atomically: true)
    }
    
   
    
    @IBAction func deleteWasPressed(_ sender: Any) {
      
        if exerciseSelector.itemTitles.count > 1 {
           let propertyList = self.readPropertyList() as NSMutableDictionary
           let exercises = propertyList["exercises"] as! NSMutableDictionary
           exercises.removeObject(forKey: exerciseSelector.selectedItem?.title)
           propertyList["exercises"] = exercises
           let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
           propertyList.write(toFile: filepath, atomically: true)
           let newExercises = propertyList["exercises"] as! [String:AnyObject]
           self.exerciseSelector.removeAllItems()
           newExercises.keys.forEach() {self.exerciseSelector.addItem(withTitle: $0) }
           propertyList["exercise"] = exerciseSelector.itemTitle(at: 0)
           exerciseSelector.selectItem(at: 0)
           self.updateBreathingConstants(exerciseTitle: exerciseSelector.itemTitle(at: 0))
        } else {
           let alert = NSAlert()
           alert.messageText = "Can't delete the last exercise"
           alert.runModal()
        }
    
    }
   
    
    func applicationDocumentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
         let basePath = paths.first ?? ""
         return basePath
     }
    func updateBreathingConstants(exerciseTitle:String){
        let propertyList = self.readPropertyList() as NSMutableDictionary
        let exercises = propertyList["exercises"] as! NSMutableDictionary
        let title = exerciseTitle
        let exercise = exercises[title] as! NSMutableDictionary
        propertyList["exercise"] = title
        propertyList["inflate"] = exercise["inflate"]
        propertyList["deflate"] = exercise["deflate"]
        propertyList["hold_after_inflate"] = exercise["hold_after_inflate"]
        propertyList["hold_after_deflate"] = exercise["hold_after_deflate"]
        let filepath = applicationDocumentsDirectory().appending("/exercises.plist")
        propertyList.write(toFile: filepath, atomically: true)
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
        let anchor = propertyList["anchor"] as! String
        let breathingInColorArray = propertyList["inflate_color"] as! NSDictionary
        let firstHoldingColorArray = propertyList["hold_color"] as! NSDictionary
        let breathingOutColorArray = propertyList["deflate_color"] as! NSDictionary

        breathingInColor.color = NSColor.init(red: CGFloat(breathingInColorArray["red"] as! NSNumber), green: CGFloat(breathingInColorArray["green"] as! NSNumber), blue: CGFloat(breathingInColorArray["blue"] as! NSNumber), alpha: 1)
        firstHoldingColor.color = NSColor.init(red: CGFloat(firstHoldingColorArray["red"] as! NSNumber), green: CGFloat(firstHoldingColorArray["green"] as! NSNumber), blue: CGFloat(firstHoldingColorArray["blue"] as! NSNumber), alpha: 1)
        breathingOutColor.color = NSColor.init(red: CGFloat(breathingOutColorArray["red"] as! NSNumber), green: CGFloat(breathingOutColorArray["green"] as! NSNumber), blue: CGFloat(breathingOutColorArray["blue"] as! NSNumber), alpha: 1)
        
       
        anchorSelector.selectItem(withTitle: anchor)
        exercises.keys.forEach() {self.exerciseSelector.addItem(withTitle: $0) }
        exerciseSelector.selectItem(withTitle: propertyList["exercise"] as! String)
        //self.updateBreathingConstants(exerciseTitle: propertyList["exercise"] as! String)
    }
    
    override func viewWillAppear() {
       let propertyList = self.readPropertyList()
       let exercises = propertyList["exercises"] as! [String:AnyObject]
       exercises.keys.forEach() {self.exerciseSelector.addItem(withTitle: $0) }
       exerciseSelector.selectItem(withTitle: propertyList["exercise"] as! String)
       self.updateBreathingConstants(exerciseTitle: propertyList["exercise"] as! String)

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
        self.view.window?.titleVisibility = .hidden
        self.view.window?.styleMask.remove(.titled)
        let propertyList = self.readPropertyList() as NSDictionary
        let anchor = propertyList["anchor"] as! String
        self.view.window?.setFrameOrigin(NSPoint(x:((NSScreen.main?.frame.width ?? 0)/2) - 200,y:((NSScreen.main?.frame.height ?? 0)/2) - 200))
       
    }
   
}
