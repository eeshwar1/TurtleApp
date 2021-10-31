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
        
        print(cos(degreesToRadians(135)))
        print(cos(degreesToRadians(45)))
        
        turtle.move(distance: 50)
        turtle.left(angle: 45)
        turtle.move(distance: 100)
        // turtle.penUp()
        turtle.right(angle: 45)
        turtle.move(distance: 150)
        // turtle.penDown()
        turtle.right(angle: 60)
        turtle.move(distance: 200)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

