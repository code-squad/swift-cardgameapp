//
//  Space.swift
//  CardGame
//
//  Created by 윤동민 on 04/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class Card {
    private(set) var shape: CardShape
    private(set) var number: CardNumber
    
    init(_ shape: CardShape, _ number: CardNumber) {
        self.shape = shape
        self.number = number
    }
}

// CustomStringConvertible 프로토콜 채택 -> 인스턴스의 고유 String 표현법으로 만들 수 있다.
extension Card: CustomStringConvertible {
    var description: String {
        return "\(shape)\(number)"
    }
}

extension Card: Equatable, Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        guard lhs.number.rawValue == rhs.number.rawValue + 1 && lhs.shape == rhs.shape else { return false }
        return true
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        if ((lhs.shape == .clover || lhs.shape == .spade) &&
            (rhs.shape == .diamond || rhs.shape == .heart)) ||
            ((lhs.shape == .diamond || lhs.shape == .heart) &&
                (rhs.shape == .spade || rhs.shape == .clover)) {
            return true
        } else {
            return false
        }
    }
}
