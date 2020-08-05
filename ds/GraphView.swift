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
          let color:NSColor = NSColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
          let ovalPath = NSBezierPath(ovalIn: NSRect(x: 49,y: 46,width: (w * 0.5),height: (h * 0.5)))
          color.set()
          ovalPath.fill()
          ovalPath.stroke()
      }
}
