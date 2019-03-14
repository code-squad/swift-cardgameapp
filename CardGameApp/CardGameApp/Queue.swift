//
//  FramePool.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 13..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct Queue<T> {
    private var pool: [T?]
    private var head = 0
    
    init(pool: [T]) {
        self.pool = pool
    }
    
    mutating func enqueue(_ element: T) {
        pool.append(element)
    }
    
    mutating func dequeue() -> T? {
        guard head < pool.count, let element = pool[head] else { return nil }
        
        pool[head] = nil
        head += 1
        
        let percentage = Double(head)/Double(pool.count)
        if pool.count > 20 && percentage < 0.5 {
            pool.removeFirst(head)
            head = 0
        }
        
        return element
    }
    
    mutating func reset() {
        self.pool.removeAll()
        self.head = 0
    }
}
