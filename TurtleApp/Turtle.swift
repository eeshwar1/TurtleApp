//
//  Turtle.swift
//  TurtleApp
//
//  Created by Venkateswaran Venkatakrishnan on 10/30/21.
//

import Foundation
import AppKit

enum AngleUnits {
    case degrees
    case radians
}
class Turtle {
    
    private var id: String = ""
    
    private var xPos: CGFloat = 0
    private var yPos: CGFloat = 0
    
    private var height: CGFloat = 10
    private var width: CGFloat = 10
    
    private var linePath: CGMutablePath = CGMutablePath()
    
    // direction the turtle is currently pointing
    // angle in degrees with 0 being north
    private var angleUnits: AngleUnits = .degrees
    private var direction: CGFloat = 0
    
    private var penDown: Bool = true
    
    private var fillColor: CGColor = .black
    private var penColor: CGColor = .black
    
    private var canvas: Canvas
    
    init(id: String, canvas: Canvas) {
        self.id = id
        self.canvas = canvas
        // self.xPos = canvas.bounds.width/2
        // self.yPos = canvas.bounds.height/2
        self.canvas.addTurlte(turtle: self)
    
    }
        
    func draw(context: CGContext?) {
       
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: xPos, y: yPos))
        path.addLine(to: CGPoint(x: xPos - width / 2, y: yPos - height))
        path.addLine(to: CGPoint(x: xPos, y: yPos - 0.8 * height))
        path.addLine(to: CGPoint(x: xPos + width / 2, y: yPos - height))
        path.closeSubpath()
    
        let rotatedPath = rotatePath(path: path, radians: degreesToRadians(direction + 90))
        
        rotatedPath.addPath(linePath)
        
        context?.setLineWidth(1.0)
        context?.setStrokeColor(self.penColor)
        context?.setFillColor(self.fillColor)
        
        context?.addPath(rotatedPath)
        
        context?.drawPath(using: .fillStroke)
    }
    
    func printDetails() {
        
        print("turtle at position (\(xPos),\(yPos)) facing: \(direction)")
        
    }
    
    // MARK: Movement
    
    func goto(x: CGFloat, y: CGFloat) {
        
        self.xPos = x
        self.yPos = y
        
    }
    
    func goto(point: CGPoint) {
        
        self.goto(x: point.x, y: point.y)
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
        
        let angleRadians = self.angleUnits == .radians ? direction : degreesToRadians(direction)
        
        xPos = xPos + (isForward ? 1 : -1) * (distance * sin(angleRadians)).rounded()
        yPos = yPos + (isForward ? 1 : -1) * (distance * cos(angleRadians)).rounded()
        
        if penDown == true {
            linePath.move(to: CGPoint(x: prevXPos, y: prevYPos))
            linePath.addLine(to: CGPoint(x: xPos, y: yPos))
        }
        
    }
    
    // MARK: Direction
    
    func radians() {
        
        self.angleUnits = .radians
        
    }
    
    func degrees() {
        
        self.angleUnits = .degrees
        
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
    
    func heading() -> CGFloat {
        return direction
    }
    
    // MARK: Pen
   
    func penup() {
        
        self.penDown = false
    }
    
    func pendown() {
        
        self.penDown = true
    }
    
    func isdown() -> Bool {
        return self.penDown
    }
    
    // MARK: Color
    
    func pencolor(color: CGColor) {
        self.penColor = color
    }
    
    func fillcolor(color: CGColor) {
        self.fillColor = color
    }
    
    func color(color: CGColor) {
        self.fillcolor(color: color)
        self.pencolor(color: color)
    }
    
 
}

