//
//  Turtle.swift
//  TurtleApp
//
//  Created by Venkateswaran Venkatakrishnan on 10/30/21.
//

import Foundation
import AppKit

class Turtle {
    
    private var id: String = ""
    private var xPos: CGFloat = 0
    private var yPos: CGFloat = 0
    
    private var height: CGFloat = 10
    private var width: CGFloat = 10
    
    private var linePath: CGMutablePath = CGMutablePath()
    
    // direction the turtle is currently pointing
    // angle in degrees with 0 being north
    private var direction: CGFloat = 0
    
    private var pen: Bool = true
    
    private var fillColor: NSColor = .black
    private var penColor: NSColor = .black
    
    private var canvas: Canvas
    
    init(id: String, canvas: Canvas) {
        self.id = id
        self.canvas = canvas
        self.xPos = canvas.bounds.width/2
        self.yPos = canvas.bounds.height/2
        draw()
    }
        
    func draw() {
        
        // print("turtle at position (\(xPos),\(yPos)) facing: \(direction)")
       
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: xPos, y: yPos))
        path.addLine(to: CGPoint(x: xPos - width / 2, y: yPos - height))
        path.addLine(to: CGPoint(x: xPos, y: yPos - 0.5 * height))
        path.addLine(to: CGPoint(x: xPos + width / 2, y: yPos - height))
        path.closeSubpath()
    
        let rotatedPath = rotatePath(path: path, radians: degreesToRadians(direction + 90))
        
        rotatedPath.addPath(linePath)
        self.canvas.addPath(id: id, path: rotatedPath)
    }
    
    func backward(distance: CGFloat) {
        
        move(distance, isForward: false)
    }
    
    func forward(distance: CGFloat) {
        
        move(distance, isForward: true)
    }
    
    fileprivate func move(_ distance: CGFloat, isForward: Bool) {
        
        let prevXPos = xPos
        let prevYPos = yPos
        xPos = xPos + (isForward ? 1 : -1) * (distance * sin(degreesToRadians(direction))).rounded()
        yPos = yPos + (isForward ? 1 : -1) * (distance * cos(degreesToRadians(direction))).rounded()
        
        if pen == true {
            linePath.move(to: CGPoint(x: prevXPos, y: prevYPos))
            linePath.addLine(to: CGPoint(x: xPos, y: yPos))
        }
        draw()
    }
    
 
    func right(angle: CGFloat) {
        
        direction = direction - angle
        
    }
   
    func left(angle: CGFloat) {
        
        direction = direction + angle
        
        if (direction > 360) {
            direction = direction.truncatingRemainder(dividingBy: 360)
        }
    }
   
    func penUp() {
        
        self.pen = false
    }
    
    func penDown() {
        
        self.pen = true
    }

    func heading() -> CGFloat {
        return direction
    }
}
