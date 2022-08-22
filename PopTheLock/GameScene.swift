//
//
//
// Created by Swift Goose.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//


import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var currentLevel: Int = 1
    var remainingCollectibles: Int = 1
    
    var startingTime = Date.now
    var endingTime = Date.now
    
    var lastEndContact = Date.now
    var lastEndContactTime: Double = 0.0
    
    let lockTop = LockTop()
    let lockBase = LockBase()
    let label = Label()
    let labelBg = LabelBackground()
    let player = Player()
    var collectible = Collectible()
    
    let victory = SKLabelNode(text: "VICTORY ACHIEVED")
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        lockBase.addChild(label)
        lockBase.addChild(labelBg)
        lockBase.addChild(player)
        lockBase.addChild(collectible)
        
        addChild(lockTop)
        addChild(lockBase)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if player.ready {
            clearPin()
        } else {
            restartLevel()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        switch currentLevel {
        case 1...4:
            player.zRotation += 0.03 * player.velocity
            
        case 5...9:
            player.zRotation += 0.04 * player.velocity
            
        case 10...14:
            player.zRotation += 0.05 * player.velocity
            
        case 15...20:
            player.zRotation += 0.06 * player.velocity
            
        default:
            player.zRotation += 0.03 * player.velocity
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        player.ready = true
        
        startingTime = Date.now
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        lastEndContactTime = Date.now.timeIntervalSince(lastEndContact)
        
        if lastEndContactTime < 1 { return }
        
        player.ready = false
        
        endingTime = Date.now
        
        restartLevel()
        
        lastEndContact = Date.now
    }
}

extension GameScene {
    func clearPin() {
        
        player.ready = false
        player.velocity *= -1
        print("remBef: \(remainingCollectibles)")
        remainingCollectibles -= 1
        print("rem: \(remainingCollectibles)")
        label.updateLabel(remainingCollectibles)
        
        collectible.run(.sequence([
            .scale(to: 0, duration: 0.1),
            .playSoundFileNamed("pop.m4a", waitForCompletion: false),
            .fadeAlpha(to: 0, duration: 0.1)
        ]))
        
        if remainingCollectibles == 0 {
            nextLevel()
        } else {
            restartLevel(close: true, advance: true)
        }
    }
    
    func nextLevel() {
        
        if currentLevel >= 3 {
            endGame()
        } else {
        
            moveLock()
            
            currentLevel += 1
            remainingCollectibles = currentLevel
            label.updateLabel(remainingCollectibles)
            labelBg.updateLabelBg(currentLevel)
            player.ready = false
            
            restartLevel()
        }
    }
    
    func moveLock() {
        let lockMoveDown = SKAction.moveTo(y: 20, duration: 0.2)
        lockMoveDown.timingMode = .easeInEaseOut
        
        let lockMoveUp = SKAction.moveTo(y: 180, duration: 0.3)
        lockMoveUp.timingMode = .easeInEaseOut
        
        lockTop.run(.sequence([
            .wait(forDuration: 0.5),
            .playSoundFileNamed("unlock.mp3", waitForCompletion: false),
            lockMoveDown,
            lockMoveUp]))
        
        let lockBaseMoveOut = SKAction.moveTo(x: -600, duration: 0.8)
        lockBaseMoveOut.timingMode = .easeInEaseOut
        
        let lockTopMoveOut = SKAction.moveTo(x: -600, duration: 0.8)
        lockTopMoveOut.timingMode = .easeInEaseOut
        
        let lockBaseMoveIn = SKAction.moveTo(x: 0, duration: 0.8)
        lockBaseMoveIn.timingMode = .easeInEaseOut
        
        let lockTopMoveIn = SKAction.moveTo(x: 0, duration: 0.8)
        lockTopMoveIn.timingMode = .easeInEaseOut
        
        lockBase.run(.sequence([
            .wait(forDuration: 1.4),
            lockBaseMoveOut,
            .moveTo(x: 600, duration: 0),
            lockBaseMoveIn]))
        
        lockTop.run(.sequence([
            .wait(forDuration: 1.4),
            lockTopMoveOut,
            .move(to: CGPoint(x: 600, y: 100), duration: 0),
            lockTopMoveIn]))
    }
    
    func endGame() {
        run(.sequence([.playSoundFileNamed("unlock.mp3", waitForCompletion: false),
                       .wait(forDuration: 0.3),
                       .playSoundFileNamed("unlock.mp3", waitForCompletion: false),
                       .wait(forDuration: 0.5),
                       .playSoundFileNamed("unlock.mp3", waitForCompletion: false),
                       .wait(forDuration: 0.4),]))
        
        lockBase.run(.fadeAlpha(to: 0, duration: 0))
        lockTop.run(.fadeAlpha(to: 0, duration: 0))
        
        lockBase.removeAllChildren()
        lockTop.removeAllChildren()
        
        victory.fontSize = 50
        victory.fontName = "Futura Bold"
        addChild(victory)
        
        let particle = SKEmitterNode(fileNamed: "Fireworks")!
        particle.position.y = -650
        particle.alpha = 0.2
        particle.setScale(8)
        addChild(particle)
    }
    
    func restartLevel(close: Bool = false, advance: Bool = false) {
        if !advance {
            remainingCollectibles = currentLevel
            label.updateLabel(remainingCollectibles)
        }
        
        player.ready = false
        
        if close {
            collectible.setClosePosition(playerVelocity: player.velocity)
        } else {
            collectible.setRandomPosition()
        }
        
        collectible.run(.sequence([
            .scale(to: 1, duration: 0.1),
            .fadeAlpha(to: 1, duration: 0.1)
        ]))
    }
}
