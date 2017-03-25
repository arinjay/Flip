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
     var rows = [[Stone]]()
    
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
        
        // Setting up constant for positioning
        let offsetX = -280
        let offsetY = -281
        let StoneSize = 80
        
        for row in 0 ..< 8 {
            
            var colArray = [Stone]()
            
            for col in 0 ..< 8{
                let stone = Stone(color: UIColor.clear,size: CGSize(width: StoneSize, height: StoneSize ))
            
                stone.position = CGPoint(x: offsetX + (col * StoneSize), y: offsetY + (col * StoneSize))
                
                stone.row = row
                stone.col = col
                
                gameboard.addChild(stone)
                colArray.append(stone)
            }
            rows.append(colArray)
        }
        
        rows[4][3].setPlayer(.white)
        rows[4][4].setPlayer(.black)
        rows[3][4].setPlayer(.white)
        rows[3][3].setPlayer(.black)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
}
