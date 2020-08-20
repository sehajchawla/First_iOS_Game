//
//  GameScene.swift
//  FirstGame
//
//  Created by Sehaj Chawla on 30/03/18.
//  Copyright © 2018 Sehaj Chawla. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //setting up the variables
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var top_label = SKLabelNode()
    var bottom_label = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        //linking the variables to the objects
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        
        top_label = self.childNode(withName: "topLabel") as! SKLabelNode
        bottom_label = self.childNode(withName: "bottomLabel") as! SKLabelNode
        
        
        //give the border of the scene a boundary
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        //applying it to the scene
        self.physicsBody = border
        
        //function called to start the game
        startGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //finding the location of your touch
        for touch in touches{
            let location = touch.location(in: self)
            
            //for the 2 player case, the upper screen controls enemy and lower screen controls us
            if currentGameType == .player2 {
                if location.y > 0{
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //finding the location of your touch
        for touch in touches{
            let location = touch.location(in: self)
            
            //for the 2 player case, the upper screen controls enemy and lower screen controls us
            if currentGameType == .player2 {
                if location.y > 0{
                   enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))

                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        
        
        //starting the game from the beginning
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        //adding scores for players as we're going along in the game
        if playerWhoWon == main {
            score[0] = score[0] + 1

            //making two actions: wait and apply impulse
            var wait = SKAction()
            wait = SKAction.wait(forDuration: 2)
            
            //apply impulse must be a SKAction for it to be put in a sequence with wait so the .run notation is useful
            var applyImpulse = SKAction()
            applyImpulse = SKAction.run {
                self.ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
            }
            
            //to call wait, it has to be pu in a sequence like this
            ball.run(SKAction.sequence([wait, applyImpulse]))
        }
        else if playerWhoWon == enemy {
            score[1] = score[1] + 1
            
            //making two actions: wait and apply impulse
            var wait = SKAction()
            wait = SKAction.wait(forDuration: 2)
            
            //apply impulse must be a SKAction for it to be put in a sequence with wait so the .run notation is useful
            var applyImpulse = SKAction()
            applyImpulse = SKAction.run {
                self.ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
            }
            
            //to call wait, it has to be pu in a sequence like this
            ball.run(SKAction.sequence([wait, applyImpulse]))
            
        }
        
        //updating the label with the value for the score whenever someone wins
        top_label.text = "\(score[1])"
        bottom_label.text = "\(score[0])"
        
    }
    
    func startGame() {
        //the frist element in the array is my score, the second is the enemy score
        score = [0,0]
        
        //updating the label with the value for the score at the start of the game
        top_label.text = "\(score[1])"
        bottom_label.text = "\(score[0])"
        
        
        //making two actions: wait and apply impulse
        var wait = SKAction()
        wait = SKAction.wait(forDuration: 2)
        
        //apply impulse must be a SKAction for it to be put in a sequence with wait so the .run notation is useful
        var applyImpulse = SKAction()
        applyImpulse = SKAction.run {
            self.ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        }
        
        //to call wait, it has to be pu in a sequence like this
        ball.run(SKAction.sequence([wait, applyImpulse]))
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        // this function is called on every frame, so keep processes to extreme minimum to treat processors well
        
        switch currentGameType {
        case .easy:
            //making enemy move with the ball
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))

            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.4))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.01))
            break
        case .player2:
            
            break
        }
        
        //checking if the ball is under the player and giving the point to enemy if that is true
        if ball.position.y <= main.position.y - 70 {
            addScore(playerWhoWon: enemy)
        }
        //checking if ball is above the enemy and giving the point to main if that is true
        else if ball.position.y >= enemy.position.y + 70 {
            addScore(playerWhoWon: main)
        }
        
    }
}
