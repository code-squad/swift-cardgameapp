//
//  Keyword.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 22..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation
import UIKit

struct Key {
    
    enum Img: String {
        case background
        case refresh
        case cardBack
        
        var name: String {
            switch self {
            case .background:
                return "bg_pattern"
            case .refresh:
                return "refresh"
            case .cardBack: return "card-back"
            }
        }
    }
    
    enum Card: Int {
        case foundations
        case baseCards
        case lastIndex
        case noStack
        case opened
        
        var count: Int {
            switch self {
            case .foundations: return 4
            case .baseCards: return 7
            case .lastIndex: return 6
            case .noStack: return 0
            case .opened: return 5
            }
        }
    }
    
    enum Observer: String {
        case tapCardDeck
        case doubleTapCard
        case openedCard
        case foundation
        case cardStacks
        
        var name: String {
            switch self {
            case .tapCardDeck: return "tapCardDeck"
            case .doubleTapCard: return "doubleTapCard"
            case .openedCard: return "openedCard"
            case .foundation: return "foundation"
            case .cardStacks: return "cardStacks"
            }
        }
    }
    
}

extension Notification.Name {
    static let didTapCardDeck = Notification.Name(Key.Observer.tapCardDeck.name)
    static let didDoubleTapCard = Notification.Name(Key.Observer.doubleTapCard.name)
    static let openedCard = Notification.Name(Key.Observer.openedCard.name)
    static let foundation = Notification.Name(Key.Observer.foundation.name)
    static let cardStacks = Notification.Name(Key.Observer.cardStacks.name)
}
