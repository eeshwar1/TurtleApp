//
//  Canvas.swift
//  TurtleApp
//
//  Created by Venkateswaran Venkatakrishnan on 10/30/21.
//

import Foundation
import AppKit

class Canvas: NSView {
    
    var paths: [String: CGPath] = [:]
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let context = NSGraphicsContext.current?.cgContext
        
        context?.setLineWidth(1.0)
        context?.setFillColor(.black)
        for (_, path) in paths {
            context?.addPath(path)
        }
        context?.drawPath(using: .fillStroke)
    }
    
    func addPath(id: String, path: CGPath) {
     
        self.paths[id] = path
    }
}
