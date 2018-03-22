//
//  ArrayExtension.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

extension Array {
    // 순서 섞는 기능. fisher-yates 알고리즘 사용.
    func shuffle() -> Array? {
        var shuffledArray = self
        var count: UInt32 = UInt32(self.count)
        guard count > 0 else { return nil }
        for (index, value) in shuffledArray.reversed().enumerated() {
            defer { count -= 1 }
            let random = Int(arc4random_uniform(count))
            shuffledArray.swapAt(index, random)
        }
        return shuffledArray
    }

}
