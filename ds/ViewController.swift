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
    @IBAction func ToggleSettings(_ sender: Any) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
               guard let vc = storyboard.instantiateController(withIdentifier: "SettingsController") as? SettingsController else {
                   fatalError("Unable to find ViewController in the storyboard")
               }
               vc.presentAsModalWindow(vc)
               vc.view.window?.title = "breathe settings💨"
               vc.view.window?.titlebarAppearsTransparent = true
               vc.view.window?.styleMask.remove(.resizable)
               //vc.view.window?.titleVisibility = .hidden
               //vc.view.window?.styleMask.insert(.fullSizeContentView)
               vc.view.window?.isOpaque = false
               vc.view.window?.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
               vc.view.window?.setFrameOrigin(NSPoint(x:0,y:0))
    }
    func readPropertyList()  -> [String:AnyObject] {
          var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
          var plistData: [String: AnyObject] = [:] //Our data
          let plistPath: String? = Bundle.main.path(forResource: "Exercises", ofType: "plist")! //the path of the data
          let plistXML = FileManager.default.contents(atPath: plistPath!)!
          do {//convert the data to a dictionary and handle errors.
              plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
          } catch {
              print("Error reading plist: \(error), format: \(propertyListFormat)")
          }
          return plistData
      }
  
    override func viewDidLoad() {
        
        super.viewDidLoad()        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            self.deflate(duration:self.readPropertyList())
        }
     
    }
    
    func inflate(duration:[String:AnyObject]){
        let self_duration = duration["inflate"] as! Double
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
                   self.hold_after_inflate(duration:duration)
            })
        
    }

    func hold_after_inflate(duration:[String:AnyObject]){
        self.view.window?.backgroundColor = NSColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.85)
        let self_duration = duration["hold_after_inflate"] as! Double

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
                            self.deflate(duration:duration)
                     })
      }

    
    func deflate(duration:[String:AnyObject]){
        self.view.window?.backgroundColor = NSColor(red: 0.1, green: 0.1, blue: 0.5, alpha: 0.85)
        let self_duration = duration["deflate"] as! Double

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
                self.hold_after_deflate(duration:duration)
            })
        
    }
  
   func hold_after_deflate(duration:[String:AnyObject]){
    self.view.window?.backgroundColor = NSColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.85)
    let self_duration = duration["hold_after_deflate"] as! Double

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
                          self.inflate(duration:duration)
                   })
    }
 


   
    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.level = .floating
       
    }
    
   
    override var representedObject: Any? {
        didSet {
        }
    }
    


}
