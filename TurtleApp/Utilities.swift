//
//  Utilities.swift
//  TurtleApp
//
//  Created by Venkateswaran Venkatakrishnan on 10/30/21.
//

import Foundation

func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
  return CGFloat.pi * degrees/180.0
}

func rotatePath(path: CGPath, radians: CGFloat) -> CGMutablePath {
    
    let bounds =  path.boundingBox
    let center = CGPoint(x: bounds.midX, y: bounds.midY)
    var transform: CGAffineTransform = .identity

    transform = transform.translatedBy(x: center.x, y: center.y)
    transform = transform.rotated(by: radians)
    transform = transform.translatedBy(x: -center.x, y: -center.y)
    
    let rotatedPath = CGMutablePath()
    rotatedPath.addPath(path, transform: transform)
    return rotatedPath
    
}

enum AngleUnits {
    case degrees
    case radians
}
