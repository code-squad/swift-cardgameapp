//
//  Card.swift
//  CardGame
//
//  Created by TaeHyeonLee on 2017. 11. 24..
//  Copyright © 2017 ChocOZerO. All rights reserved.
//

import Foundation

class Card: CustomStringConvertible {
    let suit: Suit, rank: Rank

    enum Suit: String {
        case spades = "♠️"
        case hearts = "♥️"
        case diamonds = "♦️"
        case clubs = "♣️"
    }

    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace

        static let allRawValues = Rank.two.rawValue...Rank.ace.rawValue
        static let allCases = Array(allRawValues.map { Rank(rawValue: $0)! })

        var value: String {
            switch self {
            case .ace:
                return "A"
            case .jack:
                return "J"
            case .queen:
                return "Q"
            case .king:
                return "K"
            default:
                return String(self.rawValue)
            }
        }
    }

    init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }

    var description: String {
        return "\(suit.rawValue)\(rank.value)"
    }

}

extension Card: Comparable {

    static func ==(lhs: Card, rhs: Card) -> Bool {
        if lhs.description == rhs.description {
            return true
        }
        return false
    }


    static func < (lhs: Card, rhs: Card) -> Bool {
        if lhs.rank == rhs.rank {
            switch (lhs.suit, rhs.suit) {
            case (_, .spades):
                return true
            case (.diamonds, .hearts), (.clubs, .hearts):
                return true
            case (.clubs, .diamonds):
                return true
            default:
                return false
            }
        } else {
            return lhs.rank.rawValue < rhs.rank.rawValue
        }
    }

}
