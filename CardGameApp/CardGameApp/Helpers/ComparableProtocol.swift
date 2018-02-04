//
//  Comparable.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 1. 31..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

// 기타 비교 기능 제공.
protocol ExtraComparable: Comparable {
    static func << (lhs: Self, rhs: Self) -> Bool
}
