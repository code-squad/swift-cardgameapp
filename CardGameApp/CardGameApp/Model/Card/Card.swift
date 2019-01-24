//
//  File.swift
//  CardGame
//
//  Created by 윤지영 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class Card: CustomStringConvertible {
    private let suit: Suit
    private let rank: Rank

    init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }

    var description: String {
        return "\(suit.value) \(rank.value)"
    }

    func hasSame(_ rank: Rank) -> Bool {
        return self.rank == rank
    }

    func hasSame(_ suit: Suit) -> Bool {
        return self.suit == suit
    }
}

extension Card: Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        if lhs.rank == rhs.rank {
            return lhs.suit.rawValue < rhs.suit.rawValue
        }
        if lhs.suit == rhs.suit {
            return lhs.rank.rawValue < rhs.rank.rawValue
        }
        return lhs.rank.rawValue < rhs.rank.rawValue
    }

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank == rhs.rank && lhs.suit == rhs.suit
    }
}
