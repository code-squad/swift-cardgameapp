//
//  Suit.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 4..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

//저는 종류를 한정하는 방법중에 enum이 가장 적합한 것같아 enum을 이용했고
//값 비교를 편하게 하기 위해 rawValue를 Int타입으로 만들었습니다.
enum Suit : Int, CustomStringConvertible, CaseIterable {
    case clubs = 1
    case hearts = 2
    case diamonds = 3
    case spades = 4
    //출력을 간편하게 하기 위해 문양을 출력해주는 메소드를 추가하였습니다.
    var description: String {
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
