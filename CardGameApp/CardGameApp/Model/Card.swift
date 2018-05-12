//
//  Card.swift
//  CardGame
//
//  Created by YOUTH on 2018. 1. 9..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum Side {
    case front
    case back
}

class Card: CustomStringConvertible, Comparable, Hashable, ImageSelector {

    var hashValue: Int {
        return denomination.rawValue
    }

    var side: Side = .back
    private var suit: CardDeck.Suit
    private var denomination: CardDeck.Denomination

    var description: String {
        return self.suit.rawValue + self.denomination.description
    }

    var image: String {
        switch self.side {
        case .back: return self.backImage
        case .front: return self.frontImage
        }
    }

    var backImage = "card-back"

    var frontImage: String {
        var shape = ""
        let number = self.denomination.description

        switch self.suit {
        case .heart: shape = "h"
        case .diamond: shape = "d"
        case .clover: shape = "c"
        case .spade: shape = "s"
        }
        return shape + number
    }

    init(suit: CardDeck.Suit, denomination: CardDeck.Denomination) {
        self.suit = suit
        self.denomination = denomination
        }

    static func <(lhs: Card, rhs: Card) -> Bool {
        return lhs.denomination.rawValue < rhs.denomination.rawValue
    }

    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.suit == rhs.suit
    }

    func isOnePointBigger(than next: Card) -> Bool {
        return self.denomination.isContinuous(next: next.denomination)
    }

    func isSameSuit(next: Card) -> Bool {
        return self.suit == next.suit
    }

    func isColorDifferent(with next: Card) -> Bool {
        return self.suit.description != next.suit.description
    }

    func isOnePointSmaller(than next: Card) -> Bool  {
        return self.denomination.isDescending(next: next.denomination)
    }

    func shape() -> CardDeck.Suit{
        return self.suit
    }

    func isDenominationA() -> Bool {
        return self.denomination == .ace
    }

    func isDenominationK() -> Bool  {
        return self.denomination == .thirteen
    }

    func turnOver() {
        switch self.side {
        case .back:
            self.side = .front
        case .front:
            self.side = .back
        }
    }

    func openLastCard() {
        switch self.side {
        case .back:
            self.side = .front
        case .front:
            break
        }
    }

    // stack rule
    func isHigher(than nextCard: Card) -> Bool {
        return isColorDifferent(with: nextCard) && isOnePointBigger(than: nextCard)
    }

    // foundation rule
    func isLower(than nextCard: Card) -> Bool {
        return isSameSuit(next: nextCard) && isOnePointSmaller(than: nextCard)
    }

}
