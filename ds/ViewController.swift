//
//  ViewController.swift
//  ds
//
//  Created by filipeisho on 31/07/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var coloredView: GraphView!
   
      func applicationDocumentsDirectory() -> String {
      let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
           let basePath = paths.first ?? ""
           return basePath
       }

      func readPropertyList()  -> [String:Any] {
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
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.deflate()
        }
     
    }
    
    func inflate(){
        let duration = self.readPropertyList()
        var self_duration = duration["inflate"] as! Double
        if self_duration == 0 {
            self_duration = 0.000000001
        }
        
        self.view.window?.backgroundColor = NSColor(red: 0.1, green: 0.5, blue: 0.1, alpha: 0.85)
        NSAnimationContext.runAnimationGroup({_ in
         NSAnimationContext.beginGrouping()
             NSAnimationContext.current.duration = self_duration
             var origin = self.coloredView.frame.origin
             origin.x -= 20
             origin.y -= 20

             self.coloredView.animator().setFrameOrigin(origin)
             
            NSAnimationContext.beginGrouping()
            NSAnimationContext.current.duration = self_duration
            var size = self.coloredView.frame.size
            size.height *= 2
            size.width *= 2
            self.coloredView.animator().setFrameSize(size)

            NSAnimationContext.endGrouping()
       
            NSAnimationContext.endGrouping()
        }, completionHandler:{
                   self.hold_after_inflate()
            })
        
    }

    func hold_after_inflate(){
        self.view.window?.backgroundColor = NSColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.85)
        let duration = self.readPropertyList()

        var self_duration = duration["hold_after_inflate"] as! Double
        if self_duration == 0 {
                   self_duration = 0.000000001
               }
           NSAnimationContext.runAnimationGroup({_ in
                  NSAnimationContext.beginGrouping()
                      NSAnimationContext.current.duration = self_duration
                      var origin = self.coloredView.frame.origin
                      origin.x -= 0.0000001
                      self.coloredView.animator().setFrameOrigin(origin)
                      
                     NSAnimationContext.beginGrouping()
                     NSAnimationContext.current.duration = self_duration
                     var size = self.coloredView.frame.size
                     size.height *= 1.00000001
                     size.width *= 1.00000001
                     self.coloredView.animator().setFrameSize(size)

                     NSAnimationContext.endGrouping()
                
                     NSAnimationContext.endGrouping()
                 }, completionHandler:{
                            self.deflate()
                     })
      }

    
    func deflate(){
        let duration = self.readPropertyList()
        self.view.window?.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.5, alpha: 0.85)
        var self_duration = duration["deflate"] as! Double
        if self_duration == 0 {
                   self_duration = 0.000000001
               }
        NSAnimationContext.runAnimationGroup({_ in
         NSAnimationContext.beginGrouping()
             NSAnimationContext.current.duration = self_duration
             var origin = self.coloredView.frame.origin
             origin.x += 20
             origin.y += 20
            self.coloredView.animator().setFrameOrigin(origin)
             
            NSAnimationContext.beginGrouping()
            NSAnimationContext.current.duration = self_duration
            var size = self.coloredView.frame.size
            size.height *= 0.5
            size.width *= 0.5
            self.coloredView.animator().setFrameSize(size)
            
            NSAnimationContext.endGrouping()
            NSAnimationContext.endGrouping()
        }, completionHandler:{
                self.hold_after_deflate()
            })
        
    }
  
   func hold_after_deflate(){
    self.view.window?.backgroundColor = NSColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.85)
    let duration = self.readPropertyList()

    var self_duration = duration["hold_after_deflate"] as! Double
    if self_duration == 0 {
               self_duration = 0.000000001
           }
         NSAnimationContext.runAnimationGroup({_ in
                NSAnimationContext.beginGrouping()
                    NSAnimationContext.current.duration = self_duration
                    var origin = self.coloredView.frame.origin
                    origin.x -= 0.0000001
                    self.coloredView.animator().setFrameOrigin(origin)
                    
                   NSAnimationContext.beginGrouping()
                   NSAnimationContext.current.duration = self_duration
                   var size = self.coloredView.frame.size
                   size.height *= 1.00000001
                   size.width *= 1.00000001
                   self.coloredView.animator().setFrameSize(size)

                   NSAnimationContext.endGrouping()
              
                   NSAnimationContext.endGrouping()
               }, completionHandler:{
                          self.inflate()
                   })
    }
 


   
    override func viewDidAppear() {
        super.viewDidAppear()
        print("as")
        self.view.window?.level = .floating
        self.view.window?.title = "breathe💨"
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.styleMask.remove(.resizable)
        //vc.view.window?.titleVisibility = .hidden
        self.view.window?.styleMask.insert(.fullSizeContentView)
        self.view.window?.isOpaque = false
        self.view.window?.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 100)
        let a = self.readPropertyList() as NSDictionary
        let anchor = a["anchor"] as! String
        switch anchor {
        case "Down + Left":
            self.view.window?.setFrameOrigin(NSPoint(x:0,y:0))
            
        case "Up + Left":
            self.view.window?.setFrameOrigin(NSPoint(x: 0,y:(NSScreen.main?.frame.height ?? 0)-200 ))
        case "Down + Right":
            self.view.window?.setFrameOrigin(NSPoint(x: (NSScreen.main?.frame.width ?? 0)-200,y:0))
        case "Up + Right":
            self.view.window?.setFrameOrigin(NSPoint(x: (NSScreen.main?.frame.width ?? 0)-200,y:(NSScreen.main?.frame.height ?? 0)-200 ))
        default:
            self.view.window?.setFrameOrigin(NSPoint(x:0,y:0))
        }


    }
    
   
    override var representedObject: Any? {
        didSet {
        }
    }
    


}
