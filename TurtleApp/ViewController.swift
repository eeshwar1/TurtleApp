//
//  ViewController.swift
//  TurtleApp
//
//  Created by Venkateswaran Venkatakrishnan on 10/30/21.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var canvas: Canvas!
    
    fileprivate func turtleDrawing() {
        
        let turtle: Turtle = Turtle(id: "a", canvas: canvas)
       
        let redColor: CGColor = CGColor.init(red: 255, green: 0, blue: 0, alpha: 1)
        let greenColor: CGColor = CGColor.init(red: 0, green: 0, blue: 255, alpha: 1)
        
        turtle.goto(x: 400, y: 150)
        
        for i in 1...100 {
            
            let lineColor = i%2 == 0 ? redColor: greenColor
            turtle.color(color: lineColor)
            turtle.forward(distance: 600)
            turtle.left(angle: 170)
            
        }
        
        self.canvas.needsDisplay = true
    }
    
    fileprivate func snakeKolam() {
        
        let t: Turtle = Turtle(id: "t", canvas: canvas)
        
        t.color(color: .init(red: 255, green: 0, blue: 0, alpha: 1))
        
        t.goto(x: 400, y: 100)
        
        let snake_rules: [String: String] = ["-":"r", "+":"l", "f":"f", "b":"f+f+f--f--f+f+f"]
        
        let snake_replacementRules: [String: String] = ["b": "b+f+b--f--b+f+b"]
        let snake_start: String = "b--f--b--f"
        
        let drawing = replace(seq: snake_start, replacementRules: snake_replacementRules, n: 3)
    
        draw(commands: drawing, rules: snake_rules, turtle: t)
        
        self.canvas.needsDisplay = true
    }
    
    fileprivate func ankletsOfKrishna() {
        
        let t: Turtle = Turtle(id: "t", canvas: canvas)
        
        t.color(color: .init(red: 255, green: 0, blue: 0, alpha: 1))
        
        t.goto(x: 400, y: 400)
        
        t.left(angle: 45)
    
        let krishna_rules: [String: String] = ["a":"A", "b":"B", "f":"F"]
        let krishna_replacementRules: [String: String] = ["a" : "afbfa", "b" : "afbfbfbfa" ]
        let krishna_start: String = "fbfbfbfb"
        
        let drawing = replace(seq: krishna_start, replacementRules: krishna_replacementRules, n: 3)
        
        draw(commands: drawing, rules: krishna_rules, turtle: t)
        
        self.canvas.needsDisplay = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // turtleDrawing()
        
        // snakeKolam()
        
        ankletsOfKrishna()
        
    }
    
    
    @IBAction func circleDrawing(sender: NSButton) {
        
        self.canvas.clear()
        turtleDrawing()
    }
    
    
    @IBAction func drawSnakeKolam(sender: NSButton) {
        
        self.canvas.clear()
        snakeKolam()
    }
    
    
    @IBAction func drawAnkletsOfKrishna(sender: NSButton) {
        
        self.canvas.clear()
        ankletsOfKrishna()
    }
    
    @IBAction func clearCanvas(sender: NSButton) {
        
        self.canvas.clear()
        
    }
    func replace(seq: String, replacementRules: [String: String], n: Int) -> String {
        
        var oldSeq = seq
        var newSeq = ""
        
        for _ in 0...n {
            newSeq = ""
            for (_, elem) in oldSeq.enumerated() {
                // print(elem)
                // newSeq = ""
                if let repl = replacementRules[String(elem)] {
                    newSeq = newSeq + repl
                } else {
                    newSeq = newSeq + String(elem)
                }
                
            }
            oldSeq = newSeq
        }
        return oldSeq
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
                self.A(t: turtle)
            case "B":
                self.B(t: turtle)
            case "F":
                self.F(t: turtle)
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
        t.forward(distance: 5)
    }
    
    func A(t: Turtle) {
        t.pencolor(color: CGColor.init(red: 255, green: 0, blue: 0, alpha: 1.0))
        t.circle(radius: 10, extent: 90)
    }
    
    func B(t: Turtle) {
        t.pencolor(color: CGColor.init(red: 0, green: 0, blue: 0, alpha: 1.0))
        let l: CGFloat = 5/sqrt(2)
        t.forward(distance: l)
        t.circle(radius: l, extent: 270)
        t.forward(distance: l)
        
    }
    
    func F(t: Turtle) {
        t.pencolor(color: CGColor.init(red: 0, green: 255, blue: 0, alpha: 1.0))
        t.forward(distance: 10)
        
    }

}

