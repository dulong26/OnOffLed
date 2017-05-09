//
//  ViewController.swift
//  OnOffLed
//
//  Created by Vu Thanh Tung on 5/8/17.
//  Copyright © 2017 silverpear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let marginTop: CGFloat = 50
    let margin: CGFloat = 30
    let n = 8
    var lastOnLed = -1
//    var forward = true
    var right = true, left = false, up = false, down = false
    var x = -1, y = 0, round = 0, count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        drawGreenBall()
        let _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(runningLed), userInfo: nil, repeats: true)
        
    }

    func runningLed() {
        if (lastOnLed != -1) {
            turnOffLed()
        }
        
        //Go forward and backward
//        if (forward == true) {
//            if (lastOnLed != n*n-1) {
//                lastOnLed += 1
//            } else {
//                forward = false
//                lastOnLed -= 1
//            }
//        } else {
//            if (lastOnLed != 0) {
//                lastOnLed -= 1
//            } else {
//                forward = true
//                lastOnLed += 1
//            }
//        }
//        
        //Reset circle
        if (count == n*n) {
            count = 0
            round = 0
            x = -1
            y = 0
            right = true
            down = false
            left = false
            up = false
        }
        
        //Go circle
        if (right == true)&&(down == false)&&(left == false)&&(up == false) {
            if (x != n-1-round) {
                x += 1
            } else {
                right = false
                down = true
                y += 1
            }
        } else if (right == false)&&(down == true)&&(left == false)&&(up == false) {
            if (y != n-1-round) {
                y += 1
            } else {
                down = false
                left = true
                x -= 1
            }
        } else if (right == false)&&(down == false)&&(left == true)&&(up == false) {
            if (x != 0+round) {
                x -= 1
            } else {
                left = false
                up = true
                y -= 1
                round += 1
            }
        } else {
            if (y != 0+round) {
                y -= 1
            } else {
                up = false
                right = true
                x += 1
            }
        }
        
        lastOnLed = x + n*y
        turnOnLed()
        count += 1
    }
    
    func turnOnLed() {
        if let ball = self.view.viewWithTag(100 + lastOnLed) as? UIImageView {
            ball.image = UIImage(named: "green")
        }
    }
    
    func turnOffLed() {
        if let ball = self.view.viewWithTag(100 + lastOnLed) as? UIImageView {
            ball.image = UIImage(named: "grey")
        }
    }
    
    func drawGreenBall() {
        for row in 0..<n {
            for column in 0..<n {
                let image = UIImage(named: "green")
                let ball = UIImageView(image: image)
                
                ball.center = CGPoint(x: margin + CGFloat(column)*columnSpace(numOfColumn: n) , y: marginTop + CGFloat(row)*rowSpace(numOfRow: n))
                ball.tag = 100 + column + row*n
                self.view.addSubview(ball)
            }
            
        }
    }
    
    func columnSpace(numOfColumn: Int) -> CGFloat {
        var space: CGFloat
        if (numOfColumn != 1) {
            space = (self.view.bounds.size.width - 2*margin)/CGFloat(numOfColumn - 1)
        } else {
            space = 0
        }
        return space
    }
    
    func rowSpace(numOfRow: Int) -> CGFloat {
        var space: CGFloat
        if (numOfRow != 1) {
            space = (self.view.bounds.size.height - margin - marginTop)/CGFloat(numOfRow - 1)
        } else {
            space = 0
        }
        return space
    }
}
