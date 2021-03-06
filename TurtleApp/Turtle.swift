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
    
    private var linePathColors: [CGColor] = [CGColor]()
    private var linePaths: [CGMutablePath] = [CGMutablePath]()
    private var turtleShapePath: CGMutablePath = CGMutablePath()
    private var turtleShape: CGMutablePath = CGMutablePath()
    
    // direction the turtle is currently pointing
    // angle in degrees with 0 being north
    private var angleUnits: AngleUnits = .degrees
    private var direction: CGFloat = 0
    
    private var penDown: Bool = true
    
    private var fillColor: CGColor = .black
    private var penColor: CGColor = .black
    
    private var canvas: Canvas
    
    init() {
        self.canvas = Canvas()
    }
    
    init(id: String, canvas: Canvas) {
        
        self.id = id
        self.canvas = canvas
      
        self.canvas.addTurtle(turtle: self)
        
        self.turtleShape = drawTurtleShape()
        self.turtleShapePath = self.turtleShape
    }
        
    func draw(context: CGContext?) {
        
        var rotatedPath: CGMutablePath = CGMutablePath()
        
        if self.turtleShapePath == self.turtleShape {
    
            rotatedPath = rotatePath(path: self.turtleShapePath, radians: degreesToRadians(direction + 90))
        }
        
        context?.setLineWidth(1.0)
        context?.setStrokeColor(self.penColor)
        context?.setFillColor(self.fillColor)
        
        context?.addPath(rotatedPath)
        context?.drawPath(using: .stroke)
        
        for (idx, linePath) in linePaths.enumerated() {
            
            context?.setStrokeColor(self.linePathColors[idx])
            context?.addPath(linePath)
            context?.drawPath(using: .stroke)
        }
       
    }
    
    func drawTurtleShape() -> CGMutablePath {
        
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: xPos, y: yPos))
        path.addLine(to: CGPoint(x: xPos - width / 2, y: yPos - height))
        path.addLine(to: CGPoint(x: xPos, y: yPos - 0.8 * height))
        path.addLine(to: CGPoint(x: xPos + width / 2, y: yPos - height))
        path.closeSubpath()
        
        return path
        
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
        
        self.xPos = self.xPos + (isForward ? 1 : -1) * (distance * sin(angleRadians)).rounded()
        self.yPos = self.yPos + (isForward ? 1 : -1) * (distance * cos(angleRadians)).rounded()
        
        if penDown == true {
            let linePath = CGMutablePath()
            linePath.move(to: CGPoint(x: prevXPos, y: prevYPos))
            linePath.addLine(to: CGPoint(x: xPos, y: yPos))
            self.linePaths.append(linePath)
            self.linePathColors.append(self.penColor)
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
        let maxAngle = self.angleUnits == .radians ? 2 * CGFloat.pi : 360
        
        if (direction > maxAngle) {
            direction = direction.truncatingRemainder(dividingBy: maxAngle)
        }
    }
    
    func circle(radius: CGFloat, extent: Int, steps: Int = 0) {
        
        let angleRadians = self.angleUnits == .radians ? direction : degreesToRadians(direction - 90)
        let extentRadians = self.angleUnits == .radians ? direction : degreesToRadians(CGFloat(extent))
        
        let dir: Bool = radius < 0 ? false: true

        let centerX = self.xPos - radius * cos(angleRadians)
        let centerY = self.yPos - radius * sin(angleRadians)
        
        let linePath = CGMutablePath()
        
        linePath.move(to: CGPoint(x: self.xPos, y: self.yPos))
    
        linePath.addArc(center: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: 0, endAngle: angleRadians, clockwise: dir)
    
        self.linePaths.append(linePath)
        self.linePathColors.append(self.penColor)
        
        self.left(angle: CGFloat(extent))
        
        self.xPos = linePath.currentPoint.x
        self.yPos = linePath.currentPoint.y
    }
    
    func heading() -> CGFloat {
        
        return self.angleUnits == .radians ? direction : degreesToRadians(direction)
        
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
    
    // Clear
    
    func clear() {
        
        self.linePaths = [CGMutablePath]()
        self.linePathColors = [CGColor]()
        self.turtleShapePath = CGMutablePath()
    }
    
}

