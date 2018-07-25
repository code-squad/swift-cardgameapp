//
//  Card.swift
//  CardGameApp
//
//  Created by 김수현 on 2018. 7. 23..
//  Copyright © 2018년 김수현. All rights reserved.
//

import Foundation

class Card {
    
    private var suit: Suit
    private var rank: Rank
    
    init(_ suit: Suit,_ rank: Rank) {
        self.suit = suit
        self.rank = rank
    }
    
    enum Suit: String {
        case spade = "♠️"
        case heart = "♥️"
        case diamond = "♦️"
        case club = "♣️"
        static let suits = [spade, heart, diamond, club]
        
        var value: String {
            switch self {
            case .spade: return "s"
            case .heart: return "h"
            case .diamond: return "d"
            case .club: return "c"
            }
        }
    }
    
    enum Rank: String {
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ten = "10"
        case one = "A"
        case eleven = "J"
        case twelve = "Q"
        case thirteen = "K"
        static let ranks = [two, three, four, five, six, seven, eight, nine, ten, one, eleven, twelve, thirteen]
    }
    
}

extension Card: CustomStringConvertible {
    var description: String {
        return self.suit.value + self.rank.rawValue
    }
}


