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
    private var upSide: Bool = false

    enum Suit: String {
        case spades = "♠️"
        case hearts = "♥️"
        case diamonds = "♦️"
        case clubs = "♣️"

        var value: String {
            switch self {
            case .clubs:
                return "c"
            case .diamonds:
                return "d"
            case .hearts:
                return "h"
            case .spades:
                return "s"
            }
        }

        var isRed: Bool {
            switch self {
            case .spades, .clubs:
                return false
            case .hearts, .diamonds:
                return true
            }
        }
    }

    enum Rank: Int {
        case ace = 1, two, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king

        static let allRawValues = Rank.ace.rawValue...Rank.king.rawValue
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

    var image: String {
        if isUpSide() {
            return "\(suit.value)\(rank.value)"
        }
        return Figure.Image.back.value
    }

    func isUpSide() -> Bool {
        return upSide
    }

    func turnUpSideDown() {
        upSide = !upSide
    }

}

extension Card: Comparable {

    static func == (lhs: Card, rhs: Card) -> Bool {
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

// MARK: For CardGameApp
extension Card {
    func isKing() -> Bool {
        return self.rank.value == Card.Rank.king.value
    }

    func isAce() -> Bool {
        return self.rank.value == Card.Rank.ace.value
    }

    func isOneRankDown(from another: Card) -> Bool {
        return self.rank.rawValue == another.rank.rawValue - 1
    }

    func isDifferentColor(with another: Card) -> Bool {
        return self.suit.isRed != another.suit.isRed
    }

    func isOneRankUp(from another: Card) -> Bool {
        return self.rank.rawValue == another.rank.rawValue + 1
    }

    func isSameSuit(with another: Card) -> Bool {
        return self.suit == another.suit
    }
}
