//
//  Figure.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 30..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

struct Figure {
    enum YPosition {
        case topMargin
        case cardPileTopMargin
        case betweenCards

        var value: CGFloat {
            switch self {
            case .topMargin:
                return CGFloat(20)
            case .cardPileTopMargin:
                return CGFloat(100)
            case .betweenCards:
                return CGFloat(15)
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

        var value: CGFloat {
            switch self {
            case .ratio:
                return CGFloat(1.27)
            case .countInRow:
                return CGFloat(7)
            case .yGap:
                return CGFloat(30)
            case .xGap:
                return CGFloat(1.5)
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

        var value: CGFloat {
            switch self {
            case .borderWidth:
                return CGFloat(1.0)
            case .cornerRadius:
                return CGFloat(5.0)
            }
        }
    }

    enum Gesture {
        case numberOfTapsRequired

        var value: Int {
            switch self {
            case .numberOfTapsRequired:
                return 1
            }
        }
    }
}
