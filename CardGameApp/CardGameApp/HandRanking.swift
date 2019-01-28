//
//  HandRanking.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 10..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum HandRanking : Int {
    case fourCard = 4000
    case triple = 3000
    case twoPair = 2000
    case onePair = 1000
    case highCard = 0
    
    func bundle() -> Int {
        switch self {
        case .fourCard:
            return 4
        case .triple:
            return 3
        case .onePair, .twoPair:
            return 2
        case .highCard:
            return 1
        }
    }
}
