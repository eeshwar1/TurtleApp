//
//  ViewController.swift
//  TurtleApp
//
//  Created by Venkateswaran Venkatakrishnan on 10/30/21.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var canvas: Canvas!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let turtle: Turtle = Turtle(id: "a", canvas: canvas)
        
        let turtle2: Turtle = Turtle(id: "b", canvas: canvas)
        
        // print(cos(degreesToRadians(135)))
        // print(cos(degreesToRadians(45)))
        
        turtle2.forward(distance: 50)
        turtle2.left(angle: 45)
        turtle2.forward(distance: 100)
        // turtle.penUp()
        turtle2.right(angle: 45)
        turtle2.forward(distance: 150)
        // turtle.penDown()
        turtle2.right(angle: 60)
        turtle2.backward(distance: 200)
        
        for _ in 1...100 {
            
            turtle.forward(distance: 200)
            turtle.left(angle: 170)
            
        }
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

