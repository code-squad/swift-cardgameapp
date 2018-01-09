//
//  Card.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 24..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import UIKit

class Card {
    //스페이드(spade:♠)·하트(heart:♥)·다이아몬드(diamond:◆)·클럽(club:♣)
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
    let suit: Suit
    let rank: Rank

    var description: String {
        return "\(suit.rawValue)\(rank.value)"
    }

    var isAce: Bool {
        return rank == .ace
    }

    init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
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

extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank == rhs.rank && lhs.suit == rhs.suit
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
