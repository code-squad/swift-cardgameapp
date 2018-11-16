//
//  CardProperty.swift
//  CardGame
//
//  Created by oingbong on 2018. 8. 22..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

/*
 카드 속성으로 enum 을 선택한 이유는 카드게임의 프로퍼티(?)라고 할 수 있는 카드모양 or 카드번호는 절대 변경되지 않고
 카드모양, 카드번호를 기본으로 하는 동작들만 추가 되기 때문에 열거형이 적합하다고 생각되었습니다
 */

enum CardShape: String, CustomStringConvertible {
    case heart
    case spade
    case diamond
    case club
    
    var description: String {
        switch self {
        case .heart: return "red"
        case .spade: return "black"
        case .diamond: return "red"
        case .club: return "black"
        }
    }
    
    static var allCases: [CardShape] = [heart, spade, diamond, club]
    
    static var randomIndex: Int {
        return Int(arc4random_uniform(UInt32(CardShape.allCases.count)))
    }
}

enum CardNumber: Int, CustomStringConvertible {
    case ace = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    
    var description: String {
        switch self {
        case .ace: return "A"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .ten: return "10"
        case .jack: return "J"
        case .queen: return "Q"
        case .king: return "K"
        }
    }
    
    static var allCases: [CardNumber] = [ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king]
    
    static var randomIndex: Int {
        return Int(arc4random_uniform(UInt32(CardNumber.allCases.count)))
    }
    
}

enum CardCondition {
    case back
    case front
}
