//
//
//
// Created by Swift Goose.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//


import SpriteKit

class Label: SKLabelNode {
    override init() {
        super.init()
        
        text = String(1)
        
        fontSize = 128
        fontName = "Futura Bold"
        fontColor = .white
        
        position = CGPoint(x: -8, y: -50)
        zPosition = 4
    }
    
    func updateLabel(_ level: Int) {
        text = String(level)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LabelBackground: SKNode {
    
    let ring: SKShapeNode
    let bg: SKShapeNode
    
    override init() {
        
        ring = SKShapeNode(circleOfRadius: 100)
        ring.strokeColor = .lightGray
        ring.alpha = 0.5
        ring.lineWidth = 30
        ring.zPosition = 0
        
        bg = SKShapeNode(circleOfRadius: 100)
        bg.fillColor = .blue
        bg.alpha = 0.8
        bg.lineWidth = 0
        bg.zPosition = 1
        
        super.init()
        
        addChild(ring)
        addChild(bg)
    }
    
    func updateLabelBg(_ level: Int) {
        switch level {
        case 1...4:
            bg.fillColor = .blue
            
        case 5...9:
            bg.fillColor = .green
            
        case 10...14:
            bg.fillColor = .yellow
            
        case 15...20:
            bg.fillColor = .orange
            
        default:
            bg.fillColor = .blue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
