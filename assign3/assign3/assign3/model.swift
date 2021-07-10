//
//  model.swift
//  assign3
//
//  Created by Akash Shetty on 4/11/21.
//

import Foundation





class Triples:ObservableObject {
    
    struct Tile: Hashable {
        var val : Int = 0
        var id : Int
        var row: Int
        var col: Int
    }
    
    struct Score: Hashable {
        var score: Int
        var time: Date
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(time)
        }
        
        init(score: Int, time: Date) {
            self.score = score
            self.time = time
        }
    }


    
    @Published var board: [[Tile?]] = [[nil,nil,nil,nil],[nil,nil,nil,nil],[nil,nil,nil,nil],[nil,nil,nil,nil]]
    @Published var score: Int = 0
    @Published var finished: Bool = false
    var moreMoves = true
    var seededGenerator = SeededGenerator(seed: UInt64(Int.random(in:1...1000)))
    
    init() {
        newgame(rand: true)
        spawn()
        spawn()
        spawn()
        spawn()
    }
    
    
    
    
    func newgame(rand: Bool) {
        
        if (rand) {
            seededGenerator = SeededGenerator(seed: UInt64(Int.random(in:1...1000)))
        } else {
            seededGenerator = SeededGenerator(seed: 14)
        }
        score = 0
        finished = false
//        board = [[nil,nil,nil,nil],[nil,nil,nil,nil],[nil,nil,nil,nil],[nil,nil,nil,nil]]
        for i in 0..<board.count {
            for j in 0..<board.count {
                var idIn = 1
                board[i][j] = Tile(val: 0, id: idIn, row: i, col: j)
                idIn += 1
            }
        }
    }
    
    
    public enum Direction {
        case up
        case down
        case left
        case right
    }
    
    
    
    
    func rotate() {
        var temparr = board

        for i in 0..<board.count {
            for j in 0..<board.count {
                temparr[i][j] = board[board.count - j - 1][i]
            }
        }

        board = temparr
    }
    
    
    

    func shift() {
        for i in 0..<board.count {
            for j in 0..<(board.count - 1) {
                if ((board[i][j]!.val == 1 && board[i][j + 1]!.val == 2) ||
                        (board[i][j]!.val == 2 && board[i][j]!.val == 1) ||
                        (board[i][j]!.val > 2 && board[i][j + 1]!.val == board[i][j]!.val)
                        || board[i][j]?.val == 0) {
                    
                    board[i][j]!.val = board[i][j]!.val + board[i][j + 1]!.val
                    score = score + board[i][j]!.val
                    board[i][j + 1]?.val = 0
                }
            }
        }
    }
    
    
    func isGameDone() -> Bool {
        
        let tempBoard = board
        let tempScore = score
        
        if (finished) {
            return finished
        }
        
        if (collapse(dir: Direction.up)) {
            score = tempScore
            board = tempBoard
            return finished
        }
        
        if (collapse(dir: Direction.down)) {
            score = tempScore
            board = tempBoard
            return finished
        }
        
        if (collapse(dir: Direction.right)) {
            score = tempScore
            board = tempBoard
            return finished
            
        }
        
        if (collapse(dir: Direction.left)) {
            score = tempScore
            board = tempBoard
            return finished
        } else {
            score = tempScore
            board = tempBoard
            finished = true
            return finished
        }
        
        
    }
    
    func getScore() -> Int{
        return score
    }
    
    func collapse(dir: Direction) -> Bool{
        
        var empty = true
        
        
        if (finished) {
            return false
        }
        
        for i in 0..<board.count {
            for j in 0..<board.count {
                
                if (board[i][j]!.val != 0) {
                    empty = false
                    break
                }
            
            if (empty == false) {
                break
                }
            }
        }
        
        let tempBoard = board
        
        switch dir  {
            case .left:
                shift()
            case .right:
                rotate()
                rotate()
                shift()
                rotate()
                rotate()
            case .up:
                rotate()
                rotate()
                rotate()
                shift()
                rotate()
            case .down:
                rotate()
                shift()
                rotate()
                rotate()
                rotate()
            }
        
        for i in 0..<board.count {
            for j in 0..<board.count {
                
                if (board[i][j]!.val != tempBoard[i][j]!.val) {
                    spawn()
                    return true
                }
            }
        }
        
        return false
        

        
    }
    
    func spawn() {
        
        var count = 0
        var index: [[Int?]] = [[nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, nil, nil]]
        
        for i in 0..<board.count {
            for j in 0..<board.count {
                
                if (board[i][j]!.val == 0) {
                    index[i][j] = count
                    count += 1
                }
            }
        }
        
        
        count = count - 1
        if (count != -1) {
            let newval = Int.random(in: 1...2, using: &seededGenerator)
            let pos = Int.random(in: 0...count, using: &seededGenerator)
            
            for i in 0..<index.count {
                for j in 0..<index.count {
                    
                    if (pos == index[i][j]) {
                        board[i][j]!.val = newval
                    }
                }
            }
            score += newval
        }
    }
    
}


public func rotate2DInts(input: [[Int]]) -> [[Int]] {

    var temparr = input
    for i in 0..<input.count {
        for j in 0..<input.count {
            temparr[i][j] = input[input.count - j - 1][i]
        }
    }
    return temparr
}


public func rotate2D<C> (input:[[C]]) -> [[C]] {
    var temparr = input
    for i in 0..<input.count {
        for j in 0..<input.count {
            temparr[i][j] = input[input.count - j - 1][i]
        }
    }
    
    return temparr
    
}
