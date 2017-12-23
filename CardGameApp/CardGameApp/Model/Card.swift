//
//  Card.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 24..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import Foundation

class Card {
    //스페이드(spade:♠)·하트(heart:♥)·다이아몬드(diamond:◆)·클럽(club:♣)
    enum Suit: Character {
        case spade = "♠️", heard = "♥️", diamond = "♦️", club = "♣️"
    }
    // A(ace), K(king), Q(queen), J(jack), 10, 9, 8, 7, 6, 5, 4, 3, 2
    enum Rank: Int {
        case ace = 1, two, three, four, five, six, saven, eight, nine, ten
        case jack, queen, king

        var value: String {
            switch self {
            case .ace: return "A"
            case .jack: return "J"
            case .queen: return "Q"
            case .king: return "k"
            default: return "\(self.rawValue)"
            }
        }
    }
    let suit: Suit
    let rank: Rank

    var description: String {
        return "\(suit.rawValue)\(rank.value)"
    }

    init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }
}
