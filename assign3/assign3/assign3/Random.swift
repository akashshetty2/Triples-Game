//
//  Random.swift
//  assign3
//
//  Created by Akash Shetty on 4/11/21.
//

import Foundation

struct SeededGenerator: RandomNumberGenerator {
    let seed: UInt64
    var curr: UInt64
    init(seed: UInt64 = 0) {
        self.seed = seed
        curr = seed
    }
    
    mutating func next() -> UInt64  {
        curr = (103 &+ curr) &* 65537
        curr = (103 &+ curr) &* 65537
        curr = (103 &+ curr) &* 65537
        return curr
    }
}
