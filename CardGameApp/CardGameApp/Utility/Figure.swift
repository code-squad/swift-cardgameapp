//
//  Figure.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 30..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

struct Figure {
    enum YPosition {
        case topMargin
        case cardPileTopMargin
        case betweenCards

        var value: Int {
            switch self {
            case .topMargin:
                return 20
            case .cardPileTopMargin:
                return 100
            case .betweenCards:
                return 15
            }
        }
    }

    enum XPosition {
        case cardDeck
        case openedCardDeck

        var value: Int {
            switch self {
            case .cardDeck:
                return 6
            case .openedCardDeck:
                return 5
            }
        }
    }

    enum Size {
        case ratio
        case countInRow
        case yGap
        case xGap

        var value: Double {
            switch self {
            case .ratio:
                return 1.27
            case .countInRow:
                return 7
            case .yGap:
                return 30
            case .xGap:
                return 1.5
            }
        }
    }

    enum Count {
        case cardPiles
        case foundations

        var value: Int {
            switch self {
            case .cardPiles:
                return 7
            case .foundations:
                return 4
            }
        }
    }

    enum Image {
        case back
        case refresh
        case background

        var value: String {
            switch self {
            case .back:
                return "card-back"
            case .refresh:
                return "cardgameapp-refresh-app"
            case .background:
                return "bg_pattern"
            }
        }
    }

    enum Layer {
        case borderWidth
        case cornerRadius

        var value: Double {
            switch self {
            case .borderWidth:
                return 1.0
            case .cornerRadius:
                return 5.0
            }
        }
    }

    enum TapGesture: Int {
        case once = 1, double
    }
}
