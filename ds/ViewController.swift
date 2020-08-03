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
                self.inflate()
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
