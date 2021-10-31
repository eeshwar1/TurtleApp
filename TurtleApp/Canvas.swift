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
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let context = NSGraphicsContext.current?.cgContext
        
        for turtle in turtles {
            turtle.draw(context: context)
        }
        
    }
    
    func addTurlte(turtle: Turtle) {
        self.turtles.append(turtle)
    }
    
    func getContext() -> CGContext? {
        
        if let context = NSGraphicsContext.current {
            return context.cgContext
        }
        return nil
    }
    
}
