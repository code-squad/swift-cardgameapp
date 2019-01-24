//
//  Rank.swift
//  CardGame
//
//  Created by 윤지영 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

// 이 데이터 구조를 선택한 이유:
// enum을 사용하면, 카드의 Rank 속성으로 가질 수 있는 값의 경우를 보다 직관적으로 볼 수 있기 때문입니다.
// 또한, int 값을 저장하는 enum 은 case 에 순차적으로 값을 자동 할당해주기 때문에 선언부를 간략화할 수 있다고 생각했습니다.

enum Rank: Int, CaseIterable {
    case two = 2, three, four, five, six, seven, eight, nine, ten
    case J, Q, K, A

    var value: String {
        switch self {
        case .J:
            return "J"
        case .Q:
            return "Q"
        case .K:
            return "K"
        case .A:
            return "A"
        default:
            return "\(self.rawValue)"
        }
    }
}
