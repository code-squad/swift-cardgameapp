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

enum CardShape: String {
    case heart
    case spade
    case diamond
    case club
    
    static var allCases: [CardShape] = [heart, spade, diamond, club]
    
    static var randomIndex: Int {
        return Int(arc4random_uniform(UInt32(CardShape.allCases.count)))
    }
}

enum CardNumber: String {
    case ace = "A"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case jack = "J"
    case queen = "Q"
    case king = "K"
    
    static var allCases: [CardNumber] = [ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king]
    
    static var randomIndex: Int {
        return Int(arc4random_uniform(UInt32(CardNumber.allCases.count)))
    }
    
}

enum CardCondition {
    case back
    case front
}
