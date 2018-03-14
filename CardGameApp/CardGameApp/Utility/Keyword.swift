//
//  Keyword.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 2. 23..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

enum Keyword {
    case foundationImages
    case openedCardImages
    case sevenPilesImages
    case doubleTapped
    case tappedCardDeck
    case drag

    var value: String {
        switch self {
        case .foundationImages: return "foundationImages"
        case .sevenPilesImages: return "sevenPilesImages"
        case .openedCardImages: return "openedCardImages"
        case .doubleTapped: return "doubleTapped"
        case .tappedCardDeck: return "tappedCardDeck"
        case .drag: return "drag"
        }
    }
}
