//
//  Stone.swift
//  Flip
//
//  Created by Arinjay Sharma on 3/25/17.
//  Copyright © 2017 Arinjay Sharma. All rights reserved.
//

import UIKit
import SpriteKit

class Stone: SKSpriteNode {
    
   
    
    static let thinkingTexture = SKTexture(imageNamed: "thinking")
    static let whiteTexture = SKTexture(imageNamed: "white")
    static let blackTexture = SKTexture(imageNamed: "black")
    
    func setPlayer(_ player: StoneColor){
        
        if player == .white{
            texture = Stone.whiteTexture
        }
        else if player == .black {
            texture  = Stone.blackTexture
        }
        else if player == .choice {
            texture = Stone.thinkingTexture
        }
    }

    
    var row = 0
    var col = 0
    
}
