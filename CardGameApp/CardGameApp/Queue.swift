//
//  FramePool.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 13..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct Queue<T> {
    private var pool: [T]
    
    init(pool: [T]) {
        self.pool = pool
    }
    
    mutating func enqueue(_ element: T) {
        pool.append(element)
    }
    
    mutating func dequeue() -> T? {
        if pool.count == 0 {
            return nil
        }
        return pool.removeFirst()
    }
    
    mutating func reset() {
        self.pool.removeAll()
    }
}
