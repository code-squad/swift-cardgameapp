//
//  Hand.swift
//  CardGame
//
//  Created by 윤지영 on 20/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum Hand {
    case highCard(Rank, Suit)
    case onePair(Rank, Suit)
    case twoPair(Rank, Suit)
    case threeOfAKind(Rank, Suit)
    case fourOfAKind(Rank, Suit)

    var rank: Rank {
        switch self {
        case let .highCard(rank, _): return rank
        case let .onePair(rank, _): return rank
        case let .twoPair(rank, _): return rank
        case let .threeOfAKind(rank, _): return rank
        case let .fourOfAKind(rank, _): return rank
        }
    }

    var suit: Suit {
        switch self {
        case let .highCard(_, suit): return suit
        case let .onePair(_, suit): return suit
        case let .twoPair(_, suit): return suit
        case let .threeOfAKind(_, suit): return suit
        case let .fourOfAKind(_, suit): return suit
        }
    }

    var ranking: Int {
        switch self {
        case .highCard: return 0
        case .onePair: return 1
        case .twoPair: return 2
        case .threeOfAKind: return 3
        case .fourOfAKind: return 4
        }
    }
}

extension Hand: Comparable {
    static func < (lhs: Hand, rhs: Hand) -> Bool {
        if lhs.ranking == rhs.ranking {
            return Card(suit: lhs.suit, rank: lhs.rank) < Card(suit: rhs.suit, rank: rhs.rank)
        }
        return lhs.ranking < rhs.ranking
    }
}
