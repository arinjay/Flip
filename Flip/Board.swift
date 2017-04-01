//
//  Board.swift
//  Flip
//
//  Created by Arinjay Sharma on 3/26/17.
//  Copyright © 2017 Arinjay Sharma. All rights reserved.
//

import UIKit

class Board: NSObject {

    var currentPlayer = Player.allPlayer[0]                // to board model need to which player is currently in control
    
    
    static let size = 8
    var rows = [[StoneColor]]()
    
}
