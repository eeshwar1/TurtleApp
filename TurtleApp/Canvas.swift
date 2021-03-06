//
//  Canvas.swift
//  TurtleApp
//
//  Created by Venkateswaran Venkatakrishnan on 10/30/21.
//

import Foundation
import AppKit

class Canvas: NSView {

    var turtles: [Turtle] = []
    
    var bgColor: NSColor = .white
    
    override func draw(_ dirtyRect: NSRect) {
        
        super.draw(dirtyRect)
        
        fillBackground()
        
        let context = NSGraphicsContext.current?.cgContext
        
        for turtle in turtles {
            turtle.draw(context: context)
        }
        
    }
    
    func fillBackground() {
        
        bgColor.setFill()
        bounds.fill()
    }
    
    func addTurtle(turtle: Turtle) {
        self.turtles.append(turtle)
    }
    
    func getContext() -> CGContext? {
        
        if let context = NSGraphicsContext.current {
            return context.cgContext
        }
        return nil
    }
    
    func clear() {
        
        for turtle in turtles {
            turtle.clear()
        }
        
        self.needsDisplay = true
    }
    
}
