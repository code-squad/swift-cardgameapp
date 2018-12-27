//
//  Card.swift
//  CardGame
//
//  Created by Yoda Codd on 2018. 6. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

/// 카드 모양
enum Mark {
    case spade
    case clover
    case heart
    case diamond
    
    /// 출력값 리턴을 위한 함수
    func getValue() -> String {
        switch self {
        case .spade : return ("♠️")
        case .clover : return ("♣️")
        case .heart : return ("♥️")
        case .diamond : return ("♦️")
        }
    }
}

/// 카드 넘버링
enum Numbering {
    case ace
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
    
    /// 출력값 리턴용
    func getValue() -> String {
        switch self {
        case .ace : return "A"
        case .two : return "2"
        case .three : return "3"
        case .four : return "4"
        case .five : return "5"
        case .six : return "6"
        case .seven : return "7"
        case .eight : return "8"
        case .nine : return "9"
        case .ten : return "10"
        case .jack : return "J"
        case .queen : return "Q"
        case .king : return "K"
        }
    }
}

/// 카드 객체를 만든다
class Card {
    // 카드 정보 선언
    private let numbering : Numbering
    private let mark : Mark
    
    init(mark: Mark, numbering: Numbering){
        self.mark = mark
        self.numbering = numbering
    }
    
    /// 카드정보 리턴
    func getInfo() -> String {
        return mark.getValue() + numbering.getValue()
    }
}
