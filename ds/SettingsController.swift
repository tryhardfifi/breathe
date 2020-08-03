//
//  SettingsController.swift
//  breathe
//
//  Created by filipeisho on 02/08/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class SettingsController: NSViewController {
    @IBOutlet var Apply: NSButton!
    @IBOutlet weak var coloredView: GraphView!
   // let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    @IBAction func left(_ sender: Any) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
              guard let vc = storyboard.instantiateController(withIdentifier: "SettingsController") as? SettingsController else {
                  fatalError("Unable to find SettingsController in the storyboard")
              }
              guard let button = statusItem.button else {
                        fatalError("Unable to get button")
                    }
              let popoverView = NSPopover()
              
              popoverView.contentViewController = vc
              popoverView.behavior = .transient
              button.translateOrigin(to: NSPoint(x: -10, y: -20))
              //let rect = NSRect(x: -20, y: 0, width: 100, height: 100)
              //popoverView.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        popoverView.show(relativeTo: .zero, of: button, preferredEdge: NSRectEdge.minY)
        let positioningView = NSView()
            
        positioningView.frame = (sender as AnyObject).frame

        let popover = NSPopover()
        // configure popover here

        popover.show(relativeTo: .zero, of: positioningView, preferredEdge: .maxX)

        positioningView.frame = NSMakeRect(0, -200, 10, 10)
    }
    @IBAction func Settings(_ sender: Any) {
    }
    
    
    @IBAction func applyWasPressed(_ sender: Any) {
    }
    
    @IBAction func HoldingWasUpdated(_ sender: NSSlider) {
        print(sender.integerValue)
    }
    
    @IBAction func BreathingInWasUpdated(_ sender: NSSlider) {
        print(sender.integerValue)
    }
    
    @IBAction func BreathingOutWasUpdated(_ sender: NSSlider) {
        print(sender.integerValue)
    }
    
     override func viewDidLoad() {
          super.viewDidLoad()
          DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
              self.deflate()
          }
        
      }
      
      func inflate(){
          NSAnimationContext.runAnimationGroup({_ in
           NSAnimationContext.beginGrouping()
               NSAnimationContext.current.duration = 4.0
               var origin = self.coloredView.frame.origin
               origin.x -= 0.0000001
               self.coloredView.animator().setFrameOrigin(origin)
               
              NSAnimationContext.beginGrouping()
              NSAnimationContext.current.duration = 4.0
              var size = self.coloredView.frame.size
              size.height *= 2
              size.width *= 2
              self.coloredView.animator().setFrameSize(size)

              NSAnimationContext.endGrouping()
         
              NSAnimationContext.endGrouping()
          }, completionHandler:{
                     self.deflate()
              })
          
      }
      func deflate(){
          let finalSizeX = self.coloredView.frame.size.width * 0.5
          let finalSizeY = self.coloredView.frame.size.height * 0.5
          NSAnimationContext.runAnimationGroup({_ in
           NSAnimationContext.beginGrouping()
               NSAnimationContext.current.duration = 4.0
               var origin = self.coloredView.frame.origin
               origin.x -= 0.0000001
               self.coloredView.animator().setFrameOrigin(origin)
               
              NSAnimationContext.beginGrouping()
              NSAnimationContext.current.duration = 4.0
              var size = self.coloredView.frame.size
              size.height = finalSizeX
              size.width = finalSizeY
              self.coloredView.animator().setFrameSize(size)
              
              NSAnimationContext.endGrouping()
              NSAnimationContext.endGrouping()
          }, completionHandler:{
                  //self.coloredView.frame.size.height = finalSizeX
                  //self.coloredView.frame.size.width = finalSizeY
                  self.inflate()
              })
          
      }
    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.level = .floating
       
    }
   
}
