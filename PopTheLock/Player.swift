//
//
//
// Created by Swift Goose.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//


import SpriteKit

enum CollisionType: UInt32 {
    case player = 1
    case collectible = 2
}

class Player: SKNode {
    
    let ticker: SKSpriteNode!
    var ready = false
    var velocity = CGFloat(-1)
    
    override init() {
        
        let texture = SKTexture(imageNamed: "Lock_Player")
        ticker = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        
        ticker.position = CGPoint(x: 0, y: 150)
        ticker.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ticker.setScale(0.80)
        ticker.zPosition = 2
        
        ticker.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        ticker.physicsBody?.isDynamic = true
        ticker.physicsBody?.allowsRotation = false
        ticker.physicsBody?.affectedByGravity = false
        ticker.physicsBody?.categoryBitMask = CollisionType.player.rawValue
        ticker.physicsBody?.collisionBitMask = 0
        ticker.physicsBody?.contactTestBitMask = CollisionType.collectible.rawValue
        
        super.init()
        
        addChild(ticker)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
