//
//  Board.swift
//  Flip
//
//  Created by Arinjay Sharma on 3/26/17.
//  Copyright © 2017 Arinjay Sharma. All rights reserved.
//

import UIKit
import GameplayKit

class Board: NSObject {

    var currentPlayer = Player.allPlayer[0]                // to board model need to which player is currently in control
    
    // add method to board   1. check for move within bounds  2. Position occupied or not  3. Legal move/not
                                    // taking initial as ,0  // if starting pr is 2,3  then moves to check are 1,2 etc
    static let moves = [Move(row: -1,col:-1),Move(row: 0,col:-1),Move(row: 1,col:-1),
                        Move(row: -1,col:0),Move(row: 1,col:0),Move(row: 0,col:1),
                        Move(row: -1,col:1),Move(row: 1,col:1),]
    
    
    static let size = 8
    var rows = [[StoneColor]]()
    
    func canMove(row:Int,col:Int) -> Bool{
        //test 1
        if !isInBounds(row: row, col: col) { return false }
        
        // Test 2
        let stone = rows[row][col]
        if stone != .empty {return false }
        
        
        //test 3: check if move is legal or not
        for move in Board.moves {  // loop 
            
            // create a var to track if we have passed one component atleast or not
            var passedOpponent = false
            
            // set movements variable for tracking initial movements
            var currentRow = row
            var currentCol = col
            
            //loop from here to edge of board
            for _ in  0 ..< Board.size {
                
                currentRow += move.row
                currentCol += move.col
                
                // check if new position is off the board or not if yes than break out
                guard isInBounds(row: currentRow, col: currentCol)  else { return false }
                let stone = rows[currentRow][currentCol]
                
                if (stone == currentPlayer.opponent.stoneColor){
                    passedOpponent = true
                }
                else if stone == currentPlayer.stoneColor && passedOpponent {
                    return true
                } else {
                    
                    //we found something else; bail out
                    break
                }
                
            }
        }
        return false
    }
    
    //test #1 function
    func isInBounds(row: Int,col: Int) -> Bool {
        if row < 0 {return false}
        if col < 0 {return false}
        if row >= Board.size { return false}
        if col >= Board.size {return false}
        
      return true
    }
    
    //works only if canMove it true, replaces oppo stone that of a player
    func makeMove(player: Player, row: Int, col: Int) -> [Move] {
        
        //create an array to record capture stones 
        var didCapture = [Move]()
        
        //placing stone in requested position
        rows[row][col] = player.stoneColor
        
        didCapture.append(Move(row: row, col: col))
        for move in Board.moves {
            //look in this direction for captured stones
        
            var mightCapture = [Move]()
            var currentRow = row
            var currentCol = col
        
        // count here from edge of board applying moves
        for _ in 0 ..< Board.size {
            
            currentRow += move.row
            currentCol += move.col
            
            
            //5 make sure this is as sensible move
            
            guard isInBounds(row: currentRow, col: currentCol) else { break }
            
            let stone = rows[currentRow][currentCol]
            
            if stone == player.opponent.stoneColor {
                
                // we find one of our stones, add mightcapture to did capture array
                didCapture.append(contentsOf: mightCapture)
                
                
                mightCapture.forEach {
                    rows[$0.row][$0.col] = player.stoneColor
                }
                break
            } else {
                // 9 we found something else; bail out
                break
            }
        }
     }
        return didCapture
    }
    
    
    
    func getScores() -> (black: Int, white: Int){
        
        
        var black = 0
        var white = 0
        
        rows.forEach {
            $0.forEach {
                if $0 == .black {
                    black += 1
                } else if $0 == .white {
                    white += 1
                }
            }
        }
        return (black,white)
    }
    
    
    func isWin(for player: GKGameModelPlayer) -> Bool{
        
        guard let playerObject = player as?  Player else {
            return false
        }
        let scores = getScores()
        if playerObject.stoneColor == .black {
            return scores.black > scores.white + 10
        }
        else
        {
            return scores.white > scores.black + 10
        }
    }
    
    
    
    
    
}
