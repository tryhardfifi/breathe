//
//  ColorController.swift
//  breathe
//
//  Created by filipeisho on 09/08/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class ColorController: NSViewController {
    @IBOutlet weak var breathingInColor: NSColorWell!
    @IBOutlet weak var firstHoldingColor: NSColorWell!
    @IBOutlet weak var breathingOutColor: NSColorWell!

     @IBAction func DoneWasPressed(_ sender: NSButton) {
        
        self.view.window?.performClose(sender)
        self.view.window?.close()
        
     }
    override func viewWillDisappear() {
        self.set_color(string: "deflate_color", color: breathingOutColor.color)
        self.set_color(string: "inflate_color", color: breathingInColor.color)
        self.set_color(string: "hold_color", color: firstHoldingColor.color)

     }
    override func viewDidAppear() {
               
     
    }
      override func viewDidLoad() {
          super.viewDidLoad()
//        NSColorPanel.shared.orderFront(self)



          let propertyList = self.readPropertyList()
          let exercises = propertyList["exercises"] as! [String:AnyObject]
          let anchor = propertyList["anchor"] as! String
          let breathingInColorArray = propertyList["inflate_color"] as! NSDictionary
          let firstHoldingColorArray = propertyList["hold_color"] as! NSDictionary
          let breathingOutColorArray = propertyList["deflate_color"] as! NSDictionary
          breathingInColor.color = NSColor.init(red: CGFloat(breathingInColorArray["red"] as! NSNumber), green: CGFloat(breathingInColorArray["green"] as! NSNumber), blue: CGFloat(breathingInColorArray["blue"] as! NSNumber), alpha: 1)
          firstHoldingColor.color = NSColor.init(red: CGFloat(firstHoldingColorArray["red"] as! NSNumber), green: CGFloat(firstHoldingColorArray["green"] as! NSNumber), blue: CGFloat(firstHoldingColorArray["blue"] as! NSNumber), alpha: 1)
          breathingOutColor.color = NSColor.init(red: CGFloat(breathingOutColorArray["red"] as! NSNumber), green: CGFloat(breathingOutColorArray["green"] as! NSNumber), blue: CGFloat(breathingOutColorArray["blue"] as! NSNumber), alpha: 1)
//        firstHoldingColor.activate(true)
//        breathingOutColor.activate(true)
//        breathingInColor.activate(true)

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
    
}
