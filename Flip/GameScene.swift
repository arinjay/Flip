//
//  GameScene.swift
//  Flip
//
//  Created by Arinjay Sharma on 3/25/17.
//  Copyright © 2017 Arinjay Sharma. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        
        background.blendMode = .replace   //The blend mode used to draw the sprite into the parent’s framebuffer.
        background.zPosition = 1
        addChild(background)
        
        let gameboard = SKSpriteNode(imageNamed: "board")
        gameboard.name = "board"
        gameboard.zPosition = 2
        addChild(gameboard)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
}
