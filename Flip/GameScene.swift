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
    
    var board : Board!
    
    
    var startegist: GKMonteCarloStrategist!
    
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
        
        board = Board()
        
        // Setting up constant for positioning
        let offsetX = -280
        let offsetY = -281
        let stoneSize = 80
        
        for row in 0 ..< Board.size {
            
            var colArray = [Stone]()
            
            for col in 0 ..< Board.size{
                let stone = Stone(color: UIColor.clear,size: CGSize(width: stoneSize, height: stoneSize ))
            
                stone.position = CGPoint(x: offsetX + (col * stoneSize), y: offsetY + (row * stoneSize))
                
                stone.row = row
                stone.col = col
                
                gameboard.addChild(stone)
                colArray.append(stone)
            }
            
           // board.rows.append([StoneColor](repeating: .empty, count: Board.size))
           // board.rows.append([StoneColor](repeatElement(.empty, count: Board.size)))
            board.rows.append([StoneColor](repeating: .empty, count: Board.size))
            
            // 7: add each column to the rows array
            
            rows.append(colArray)

        }
        
        
        rows[4][3].setPlayer(.white)
        rows[4][4].setPlayer(.black)
        rows[3][4].setPlayer(.white)
        rows[3][3].setPlayer(.black)
        
        board.rows[4][3] = .white
        board.rows[4][4] = .black
        board.rows[3][4] = .white
        board.rows[3][3] = .black
        
        
        
                    startegist = GKMonteCarloStrategist()
                    startegist.budget = 100
                    startegist.explorationParameter = 1
                    startegist.randomSource = GKRandomSource.sharedRandom()
                    startegist.gameModel = board
     }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //1: unwrap the first touch
        guard let touch = touches.first else { return }
        
        //2: find the game board, or return if it Somehow could not be found 
        
        guard let gameBoard = childNode(withName: "board") else { return }
        
        //3 figure out where on the game board touch has landed
        let location = touch.location(in: gameBoard)
        
        //4 pull out an array of nodes on that location
        let nodesAtPoint = nodes(at: location)
        
        //5 filter out the nodes that aren't stones
        let tappedStones = nodesAtPoint.filter { $0 is Stone}
        
        //6 if no stone was tapped; bail out
        
        guard tappedStones.count > 0 else { return }
        let tappedStone = tappedStones[0] as! Stone
        
        //7 pass the tapped stones row and column into our new canMove
        if board.canMove(row: tappedStone.row, col: tappedStone.col){
            //print msg
            
            
        //    print("Move is legal")
            makeMove(row: tappedStone.row, col: tappedStone.col)
        
        }else{
            print("move is illegal")
        }
    }
    
//    func makeMove (row:Int, col:Int) {
//        
//        let caputured = board.makeMove(player: board.currentPlayer, row: row, col: col)
//        for move in caputured {
//             let stone = rows[move.row][move.col]
//            
//            //update who owns it
//            stone.setPlayer(board.currentPlayer.stoneColor)
//            
//            //make it 120% of normal size
//            
//            stone.xScale = 1.2
//            stone.yScale = 1.2
//            // animate down to 100%
//            
//            
//            stone.run(SKAction.scale(by: 1, duration: 0.5))
//        }
//        
//        //change player
//        
//        board.currentPlayer = board.currentPlayer.opponent
//    }

    func makeMove(row: Int, col: Int) {
        
        // find the list of captured stones
        let captured = board.makeMove(player: board.currentPlayer, row: row, col: col)
        for move in captured {
            
            // pull out the sprite for each captured stone
            let stone = rows[move.row][move.col]
            
            // update who owns it
            stone.setPlayer(board.currentPlayer.stoneColor)
            
            // make it 120% of its normal size
            stone.xScale = 1.2
            stone.yScale = 1.2
            
            // animate it down to 100%
            stone.run(SKAction.scale(to: 1, duration: 0.5))
        }
        
        // change players
        board.currentPlayer = board.currentPlayer.opponent
    }
    
    
    
    
    
    
    
    
//    func makeAIMove(){
//        
//        DispatchQueue.global(qos: QOS_CLASS_USER_INITIATED).async { [unowned self] in
//        let strategistTime = CFAbsoluteTimeGetCurrent()
//            
//            guard let move = self.startegist.bestMoveForActivePlayer() as?  Move else {return }
//            
//            let delta = CFAbsoluteTimeGetCurrent() - strategistTime
//            
//            DispatchQueue.main.async { [unowned self] in
//            
//                self.rows[move.row][move.col].setPlayer(.choice)
//                
//                let aiTimeCeiling = 3.0
//                let delay = min(aiTimeCeiling - delta, aiTimeCeiling)
//                
//                DispatchQueue.main.after(when: .now() + delay){ [unowned self] in
//                    
//                    self.makeMove(row: move.row, col: move.col)
//                    
//            }
//        
//        
//    }
//    
//    
//    
//}
//}

    func makeAIMove() {
        
        // 1: push all work to a background thread
        DispatchQueue.global(qos: .userInitiated).async { [unowned
            self] in
            
            // 2: get the current time
            let strategistTime = CFAbsoluteTimeGetCurrent()
            
            // 3: calculate the best AI move
            guard let move =
                self.startegist.bestMoveForActivePlayer() as? Move else { return }
            
            // 4: figure out how much time the AI spent thinking
            let delta = CFAbsoluteTimeGetCurrent() - strategistTime
            
            // 5: set the AI's chosen tile to the "thinking" texture
            DispatchQueue.main.async { [unowned self] in
                self.rows[move.row][move.col].setPlayer(.choice)
            }
            
            // 6: wait for at least three seconds
            let aiTimeCeiling = 3.0
            let delay = min(aiTimeCeiling - delta, aiTimeCeiling)
            
            // 7: after at least three seconds have passed, make the move for real
            DispatchQueue.main.asyncAfter(deadline: .now() + delay)
            { [unowned self] in
                
                self.makeMove(row: move.row, col: move.col)
            }
        }
    }
    
}




