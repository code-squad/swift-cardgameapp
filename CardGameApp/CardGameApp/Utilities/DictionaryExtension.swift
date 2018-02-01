//
//  DictionaryExtension.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 1. 31..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

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
