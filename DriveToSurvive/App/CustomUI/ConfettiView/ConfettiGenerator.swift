//
//  ConfettiGenerator.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/28/21.
//

import UIKit
import Lottie

let CONFETTI_DISAPPEARING_DELAY = 2.2

enum Colors {
    static let red = UIColor(red: 249.0/255.0, green: 223.0/255.0, blue: 58.0/255.0, alpha: 1.0)
    static let blue = UIColor(red: 145.0/255.0, green: 228.0/255.0, blue: 221.0/255.0, alpha: 1.0)
    static let green = UIColor(red: 225.0/255.0 , green: 146/255, blue: 112/255.0, alpha: 1.0)
    static let yellow = UIColor(red: 192.0/255.0, green: 108/255, blue: 132.0/255.0, alpha: 1.0)
    static let yellow2 = UIColor(red: 160.0/255.0, green: 177/255, blue: 222.0/255.0, alpha: 1.0)
}

enum Images {
    static let box = UIImage(named: "Box")!
    static let circle = UIImage(named: "Circle")!
}

var colors:[UIColor] = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.yellow2
]

var images:[UIImage] = [
    Images.box
    //Images.circle
]

var velocities:[Int] = [
    300,
    210,
    250,
    350
]

private func generateEmitterCells() -> [CAEmitterCell] {
    var scall_size = 0.0
    if UIScreen.main.scale>2.5 {
        scall_size = Double(UIScreen.main.scale * 0.06)
    } else{
        scall_size = Double(UIScreen.main.scale * 0.15)
    }
    
    var cells:[CAEmitterCell] = [CAEmitterCell]()
    for index in 0..<20 {
        let cell = CAEmitterCell()
        
        cell.birthRate = 3.2
        cell.lifetime = 14.0
        cell.lifetimeRange = 0
        cell.velocity = CGFloat(getRandomVelocity())
        cell.velocityRange = 0
        cell.emissionLongitude = CGFloat(Double.pi)
        cell.emissionRange = 1.5
        cell.spin = 10
        cell.spinRange = 5
        cell.color = getNextColor(i: index)
        cell.contents = getNextImage(i: index)
        cell.scaleRange = 0.15
        cell.scale = CGFloat(scall_size)
        cell.xAcceleration = 3.0
        cell.yAcceleration = 3.0
        
        cells.append(cell)
        
    }
    return cells
}

private func getRandomVelocity() -> Int {
    return velocities[getRandomNumber()]
}

private func getRandomNumber() -> Int {
    return Int(arc4random_uniform(4))
}

private func getNextColor(i:Int) -> CGColor {
    if i <= 4 {
        return colors[0].cgColor
    } else if i <= 8 {
        return colors[1].cgColor
    } else if i <= 12 {
        return colors[2].cgColor
    } else if i <= 16{
        return colors[3].cgColor
    }else{
        return colors[4].cgColor
    }
}

private func getNextImage(i:Int) -> CGImage {
    if (i % 4 != 0) {
        return Images.box.cgImage!
    } else {
        return Images.circle.cgImage!
    }
}


func startConfetti(mainView: UIView) {

    let emitter = CAEmitterLayer()
    emitter.emitterPosition = CGPoint(x: 50, y: -10)
    emitter.emitterShape = CAEmitterLayerEmitterShape.line
    emitter.emitterSize = CGSize(width: 1000, height: 2.0)
    emitter.emitterCells = generateEmitterCells()
    mainView.layer.addSublayer(emitter)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + CONFETTI_DISAPPEARING_DELAY) {
        emitter.birthRate = 0.0
    }
}

