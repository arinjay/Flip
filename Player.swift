//
//  Player.swift
//  Flip
//
//  Created by Arinjay Sharma on 4/1/17.
//  Copyright © 2017 Arinjay Sharma. All rights reserved.
//

import UIKit
import GameplayKit

class Player: NSObject,GKGameModelPlayer{
    
    var playerId: Int
    
    // create a static array that store white & black player count
    static let allPlayer = [Player(stone:.black), Player(stone:.white)]
    
    // property to store playerColor
    var stoneColor: StoneColor
    
    init(stone: StoneColor) {
        stoneColor = stone
        self.playerId = stone.rawValue
    }
    
    // a computed property to return players opponent
    
    var opponent: Player {
        if stoneColor == .black {
            return Player.allPlayer[1]
        }
         else{
            return Player.allPlayer[0]
        }
    }
}

