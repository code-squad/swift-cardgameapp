//
//  Number.swift
//  CardGame
//
//  Created by 심 승민 on 2017. 11. 24..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// Number : King(13), Queen(12), Jack(11), 10 ~ 2, Ace(1) 중 하나
// 선택이유 : 카드의 모양과 숫자는 선택지가 정해져 있으므로 enum 선택.
enum Number: Int, EnumCollection {
    case ace = 1, two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
}

// 숫자 출력 포맷. jack~ace는 K~A 형태, 그 외의 케이스는 숫자 형태.
extension Number: CustomStringConvertible {
    var description: String {
        switch self {
        case .king: return "K"
        case .queen: return "Q"
        case .jack: return "J"
        case .ace: return "A"
        default: return String(self.rawValue)
        }
    }

}

extension Number: Equatable, Comparable, ExtraComparable {
    static func == (lhs: Number, rhs: Number) -> Bool {
        guard lhs.rawValue == rhs.rawValue else { return false }
        return true
    }
    static func < (lhs: Number, rhs: Number) -> Bool {
        guard lhs.rawValue < rhs.rawValue else { return false }
        return true
    }

    // 두 카드 숫자의 차이가 1이면 true 반환.
    static func << (lhs: Number, rhs: Number) -> Bool {
        guard abs(rhs.rawValue-lhs.rawValue) == 1 else { return false }
        return true
    }

}

extension Number {
    var filename: String {
        return self.description
    }
}
