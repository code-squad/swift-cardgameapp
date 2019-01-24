//
//  Suit.swift
//  CardGame
//
//  Created by 윤지영 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

// 이 데이터 구조를 선택한 이유:
// enum을 사용하면, 카드의 suit 속성으로 가질 수 있는 값의 경우를 보다 직관적으로 볼 수 있기 때문입니다.

enum Suit: Int, CaseIterable {
    case clubs = 1, hearts, diamonds, spades

    var value: Character {
        switch self {
        case .clubs:
            return "♣️"
        case .hearts:
            return "♥️"
        case .diamonds:
            return "♦️"
        case .spades:
            return "♠️"
        }
    }
}
