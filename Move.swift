//
//  Move.swift
//  Flip
//
//  Created by Arinjay Sharma on 4/1/17.
//  Copyright © 2017 Arinjay Sharma. All rights reserved.
//

import UIKit
import GameplayKit

class Move: NSObject,GKGameModelUpdate {
    
    var row: Int
    var col: Int
    
    var value = 0
    
    init(row:Int, col:Int) {
        self.row = row
        self.col = col
    }
    

}
