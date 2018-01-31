//
//  Extensions.swift
//  CardGame
//
//  Created by 심 승민 on 2017. 11. 30..
//  Copyright © 2017년 JK. All rights reserved.
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

extension Dictionary where Value == Int {
    // 딕셔너리 값이 Int인 경우, 결과값을 누적해서 업데이트 가능.
    mutating func updateTable(forKey key: Key) {
        // 해당 키의 기존 값이 있는 경우.
        if let prevNumberCount = self[key] {
            // 기존 값에 +1 한 값 저장.
            self.updateValue(prevNumberCount+1, forKey: key)
        } else {
            // 첫 값인 경우, 해당 키의 값에 1 저장.
            self.updateValue(1, forKey: key)
        }
    }
}
