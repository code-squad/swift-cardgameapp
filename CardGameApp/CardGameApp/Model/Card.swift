//
//  Card.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 24..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class Card {
    let suit: Suit
    let rank: Rank

    enum Suit: Character, EnumCollection {
        case spade = "♠️", heart = "♥️", diamond = "♦️", club = "♣️"

        var value: String {
            switch self {
            case .spade: return "s"
            case .heart: return "h"
            case .diamond: return "d"
            case .club: return "c"
            }
        }
        static var allTypes = Array(Suit.cases())
    }

    // A(ace), K(king), Q(queen), J(jack), 10, 9, 8, 7, 6, 5, 4, 3, 2
    enum Rank: Int, EnumCollection {
        case ace = 1, two, three, four, five, six, saven, eight, nine, ten
        case jack, queen, king

        var value: String {
            switch self {
            case .ace: return "A"
            case .jack: return "J"
            case .queen: return "Q"
            case .king: return "K"
            default: return "\(self.rawValue)"
            }
        }
        static var allTypes = Array(Rank.cases())
    }

    init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }
}
// MARK: Public Methods
extension Card {
    var description: String {
        return "\(suit.rawValue)\(rank.value)"
    }

    func isSameSuitAndNextRank(with card: Card?) -> Bool {
        return self.isSameSuit(with: card) && self.isNextRank(of: card)
    }

    func isDifferentColorAndPreviousRank(with card: Card?) -> Bool {
        return self.isDifferentColor(with: card) && self.isPreviousRank(of: card)
    }

    func makeImage() -> UIImage {
        let name = (suit.value + rank.value)
        if let image = UIImage(named: name) {
            return image
        }
        return UIImage()
    }

    func makeBackImage() -> UIImage {
        if let image = UIImage(named: "card-back") {
            return image
        }
        return UIImage()
    }

}
// MARK: Private Methods
extension Card {
    private var isAce: Bool {
        return self.rank == .ace
    }

    private var isKing: Bool {
        return self.rank == .king
    }

    private var isRed: Bool {
        return self.suit == .heart || self.suit == .diamond
    }

    private var isBlack: Bool {
        return self.suit == .spade || self.suit == .club
    }

    private func isDifferentColor(with card: Card?) -> Bool {
        guard let compare = card else {
            return true
        }
        return self.isRed && compare.isBlack || self.isBlack && compare.isRed
    }

    private func isNextRank(of card: Card?) -> Bool {
        guard let pre = card else {
            return self.isAce
        }
        return self.rank.rawValue == pre.rank.rawValue + 1
    }

    private func isPreviousRank(of card: Card?) -> Bool {
        guard let next = card else {
            return self.isKing
        }
        return self.rank.rawValue + 1 == next.rank.rawValue
    }

    private func isSameSuit(with card: Card?) -> Bool {
        guard let compare = card else {
            return true
        }
        return self.suit == compare.suit
    }
}

protocol EnumCollection: Hashable {}
extension EnumCollection {
    static func cases() -> AnySequence<Self> {
        typealias SelfType = Self
        return AnySequence { () -> AnyIterator<SelfType> in
            var enumIndex = 0
            return AnyIterator {
                // enumIndex번째 있는 value를 as타입으로 반환
                let current: Self = withUnsafeBytes(of: &enumIndex) {
                    $0.load(as: SelfType.self)
                }
                // 현재 enum의 순서(hashValue)와 enumIndex가 같다면, 다음으로!
                guard current.hashValue == enumIndex else { return nil }
                enumIndex += 1
                return current
            }
        }
    }
}
