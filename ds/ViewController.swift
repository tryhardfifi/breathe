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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
        //self.moveViewWithAnimationDefaultDuration()
        //self.moveViewWithAnimationCustomDuration()
        self.bitch()
        //self.inflate()

        //self.animatorProxyAndKeyframeAnimations()
        }
       
        
    }
    func inflate(){
        NSAnimationContext.runAnimationGroup({_ in
       print("fsdf")

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
                print("complete")
                   self.deflate()
            })
        
    }
    func deflate(){
        let finalSizeX = self.coloredView.frame.size.width * 0.5
        let finalSizeY = self.coloredView.frame.size.height * 0.5
        
        NSAnimationContext.runAnimationGroup({_ in
       print("fsdf")

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
                print("complete")
                //self.coloredView.frame.size.height = finalSizeX
                //self.coloredView.frame.size.width = finalSizeY
            self.coloredView.translateOrigin(to: NSPoint(x: 0, y: 0))
            self.coloredView.setFrameSize(NSSize(width: finalSizeX, height: finalSizeY))
            self.inflate()
            })
        
    }
    func bitch(){
        print("FS")

        let posAnimation = CAKeyframeAnimation()
               posAnimation.duration = 3.0
               let x = self.coloredView.frame.origin.x
               let y = self.coloredView.frame.origin.y
               posAnimation.values = [CGPoint(x: x, y: y),CGPoint(x: x+100, y: y),CGPoint(x: x+200, y: y),CGPoint(x: x+400, y: y+200)]
               posAnimation.keyTimes = [0.0,0.5,0.8,1.0]
        posAnimation.timingFunctions = [CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear),CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear),CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)]
               posAnimation.autoreverses = true
               posAnimation.repeatCount = Float.greatestFiniteMagnitude

               let sizeAnimation = CABasicAnimation(keyPath: "frameSize")
               sizeAnimation.fromValue = self.coloredView.frame.size
               sizeAnimation.toValue = CGSize(width: 50, height: 50)
               sizeAnimation.duration = 3.0
               sizeAnimation.autoreverses = true
               sizeAnimation.repeatCount = Float.greatestFiniteMagnitude
        
               var existingAnimations = self.coloredView.animations
               existingAnimations["frameOrigin"] = posAnimation
               existingAnimations["frameSize"] = sizeAnimation
               self.coloredView.animations = existingAnimations
               //self.coloredView.animator().setFrameOrigin(CGPoint(x: x+400, y: y))
               self.coloredView.animator().frame = CGRect(x: x+400, y: y+200, width: 50, height: 50)

    }

    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.level = .floating
       
    }
    
   
    override var representedObject: Any? {
        didSet {

        // Update the view, if already loaded.
        }
    }
    


}
