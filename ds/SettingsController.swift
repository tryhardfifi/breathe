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
              //self.deflate()
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
          NSAnimationContext.runAnimationGroup({_ in
           NSAnimationContext.beginGrouping()
               NSAnimationContext.current.duration = 4.0
               var origin = self.coloredView.frame.origin
               origin.x -= 0.0000001
               self.coloredView.animator().setFrameOrigin(origin)
               
              NSAnimationContext.beginGrouping()
              NSAnimationContext.current.duration = 4.0
              var size = self.coloredView.frame.size
              size.height *= 0.5
              size.width *= 0.5
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
