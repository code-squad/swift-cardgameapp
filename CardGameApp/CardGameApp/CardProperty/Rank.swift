//
//  Number.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 4..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

//Suit와 마찬가지 이유로 enum과 Int타입의 rawValue를 사용했습니다.
enum Rank : Int, CustomStringConvertible, CaseIterable {
    case two = 2, three, four, five, six, seven, eight, nine, ten
    case J, Q, K, A
    //편하게 출력하도록 도와주는 메소드를 추가하였습니다.
    var description: String {
        switch self {
        case .A:
            return "A"
        case .J:
            return "J"
        case .Q:
            return "Q"
        case .K:
            return "K"
        default:
            return "\(self.rawValue)"
        }
    }
}

