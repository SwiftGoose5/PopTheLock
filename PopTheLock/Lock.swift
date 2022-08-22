//
//
//
// Created by Swift Goose.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//


import SpriteKit

class LockTop: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "Lock_Top")
        
        super.init(texture: texture, color: .white, size: texture.size())
        
        name = "lock_top"
        position = CGPoint(x: 0, y: 100)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setScale(1.5)
        zPosition = -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LockBase: SKNode {
    
    let base: SKShapeNode!
    
    override init() {
        base = SKShapeNode(circleOfRadius: 200)
        base.strokeColor = .gray
        base.fillColor = SKColor(red: 38.0/255.0, green: 38.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        base.lineWidth = 30
        
        super.init()
        
        position = CGPoint(x: 0, y: -100)
        zPosition = 0
        
        addChild(base)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
