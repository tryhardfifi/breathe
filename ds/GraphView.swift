//
//  GraphView.swift
//  breathe
//
//  Created by filipeisho on 02/08/2020.
//  Copyright © 2020 filipeisho. All rights reserved.
//

import Cocoa

class GraphView: NSView {
        
   
      override func draw(_ dirtyRect: NSRect) {
          let h = dirtyRect.height
          let w = dirtyRect.width
          var color:NSColor = NSColor.init(red: 211/255, green: 155/255, blue: 104/255, alpha: 0.8)
          //color = NSColor.orange.withAlphaComponent(0.65)
          let x = self.frame.size.width
          var ovalPath = NSBezierPath(ovalIn: NSRect(x: 40,y: 40,width: (w * 0.65),height: (h * 0.65)))

       
     
          color.set()
          ovalPath.fill()
          ovalPath.stroke()
        

//          var drect = NSRect(x: (w * 0.66),y: (h * 0.66),width: (w * 0.5),height: (h * 0.5))
//
//          var bpath:NSBezierPath = NSBezierPath(rect: drect)
//
//          color.set()
//          drect.fill()
//          bpath.stroke()
//
//
//          color = NSColor.red
//          drect = NSRect(x: (w * 0.33),y: (h * 0.33),width: (w * 0.5),height: (h * 0.5))
//          bpath = NSBezierPath(rect: drect)
//
//          color.set()
//          drect.fill()
//
//          color = NSColor.blue
//
//          drect = NSRect(x: (w * 0),y: (h * 0),width: (w * 0.5),height: (h * 0.5))
//          bpath = NSBezierPath(rect: drect)
//
//          color.set()
//          drect.fill()
//          bpath.stroke()




      }
}