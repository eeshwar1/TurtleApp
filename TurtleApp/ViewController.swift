//
//  ViewController.swift
//  TurtleApp
//
//  Created by Venkateswaran Venkatakrishnan on 10/30/21.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var canvas: Canvas!
    
    var t: Turtle = Turtle()
    
    fileprivate func turtleDrawing() {
        let turtle: Turtle = Turtle(id: "a", canvas: canvas)
        
        
        let turtle2: Turtle = Turtle(id: "b", canvas: canvas)
        

        turtle.color(color: .init(red: 255, green: 0, blue: 0, alpha: 1))
        turtle2.color(color: .init(red: 0, green: 255, blue: 0, alpha: 1))
        
        turtle2.goto(x: 300, y: 200)
        turtle2.forward(distance: 50)
        turtle2.left(angle: 45)
        turtle2.forward(distance: 100)
        // turtle.penup()
        turtle2.right(angle: 45)
        turtle2.forward(distance: 150)
        // turtle.pendown()
        turtle2.right(angle: 60)
        turtle2.backward(distance: 200)
        
        turtle.goto(x: 100, y: 100)
        
        for _ in 1...100 {
            
            turtle.forward(distance: 200)
            turtle.left(angle: 170)
            
        }
    }
    
    fileprivate func snakeKolam() {
        self.t.color(color: .init(red: 255, green: 0, blue: 0, alpha: 1))
        
        
        self.t.goto(x: 300, y: 300)
        let snake_rules: [String: String] = ["-":"r", "+":"l", "f":"f", "b":"f+f+f--f--f+f+f"]
        
        let snake_replacementRules: [String: String] = ["b": "b+f+b--f--b+f+b"]
        let snake_start: String = "b--f--b--f"
        
        let drawing = replace(seq: snake_start, replacementRules: snake_replacementRules, n: 3)
    
        draw(commands: drawing, rules: snake_rules, turtle: t)
    }
    
    fileprivate func ankletsOfKrishna() {
        
        self.t.color(color: .init(red: 255, green: 0, blue: 0, alpha: 1))
        
        self.t.goto(x: 200, y: 200)
        
        self.t.left(angle: 45)
    
        let krishna_rules: [String: String] = ["a":"A", "b":"B", "f":"F"]
        let krishna_replacementRules: [String: String] = ["a" : "afbfa", "b" : "afbfbfbfa" ]
        let krishna_start: String = "fbfbfbfb"
        
        let drawing = replace(seq: krishna_start, replacementRules: krishna_replacementRules, n: 3)
        
        draw(commands: drawing, rules: krishna_rules, turtle: t)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.t = Turtle(id:"t", canvas: canvas)
        
        // turtleDrawing()
        
        // snakeKolam()
        
        ankletsOfKrishna()
        
    }
    
    func replace(seq: String, replacementRules: [String: String], n: Int) -> String {
        var newSeq = ""
        
        for _ in 0...n {
            for (_, elem) in seq.enumerated() {
                // print(elem)
                if let repl = replacementRules[String(elem)] {
                    newSeq = newSeq + repl
                } else {
                    newSeq = newSeq + String(elem)
                }
            }
        }
        return newSeq
    }
    
    func draw(commands: String, rules: [String: String], turtle: Turtle) {
        for (_, b) in commands.enumerated() {
            let cmd = rules[String(b)]
            
            switch cmd {
            case "f":
                // print("\nforward")
                self.f(t: turtle)
            case "r":
                // print("\nright ")
                self.r(t: turtle)
            case "l":
                // print("\nleft")
                self.l(t: turtle)
            case "A":
                self.A(t: t)
            case "B":
                self.B(t: t)
            case "F":
                self.F(t: t)
            default:
                draw(commands: cmd!, rules: rules, turtle: turtle)
                
            }
    
            
        }
        
    }
    
    func r(t: Turtle) {
        t.right(angle: 45)
    }
    
    func l(t: Turtle) {
        t.left(angle: 45)
    }
    
    func f(t: Turtle) {
        t.forward(distance: 15)
    }
    
    func A(t: Turtle) {
        t.pencolor(color: CGColor.init(red: 255, green: 0, blue: 0, alpha: 1.0))
        t.circle(radius: 10, extent: 90, steps: 0)
    }
    
    func B(t: Turtle) {
        t.pencolor(color: CGColor.init(red: 0, green: 0, blue: 0, alpha: 1.0))
        let l: CGFloat = 5/sqrt(2)
        t.forward(distance: l)
        t.circle(radius: l, extent: 270, steps: 0)
        t.forward(distance: l)
        
    }
    
    func F(t: Turtle) {
        t.pencolor(color: CGColor.init(red: 0, green: 255, blue: 0, alpha: 1.0))
        t.forward(distance: 10)
        
    }

}

