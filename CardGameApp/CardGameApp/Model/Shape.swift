//
//  Shape.swift
//  CardGame
//
//  Created by 심 승민 on 2017. 11. 24..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// Shape : Spades > Hearts > Diamonds > Clubs
// 선택이유 : 카드의 모양과 숫자는 선택지가 정해져 있으므로 enum 선택.
enum Shape: String, EnumCollection {
    case spades = "s"
    case hearts = "h"
    case diamonds = "d"
    case clubs = "c"
}

// 모양 출력 포맷. enum의 원시값 형태.
extension Shape: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}

// 모양 비교 시, enum의 해시값으로 비교.
extension Shape: Equatable, Comparable {
    static func == (lhs: Shape, rhs: Shape) -> Bool {
        guard lhs.hashValue == rhs.hashValue else { return false }
        return true
    }
    static func < (lhs: Shape, rhs: Shape) -> Bool {
        // 해시값이 작을수록 카드패의 가치가 높아지므로, 역순 비교.
        guard lhs.hashValue > rhs.hashValue else { return false }
        return true
    }

}
