//
//  Card.swift
//  CardGame
//
//  Created by jack on 2018. 1. 6..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation
import UIKit

protocol CardController {
    
}

class Card {
    private var suit : Suits, rank : Ranks
    private var side : Side = .back
    
    init(_ suit : Suits  , _ rank : Ranks) {
        self.suit = suit
        self.rank = rank
    }
    
    enum Side {
        case front
        case back
    }
    
    //하나의 범주로 묶어 사용하고, 한정된 값들이기 때문에 enum을 선택하였습니다.
    enum Suits : String, generateAllCases {
        case spade = "s"
        case heart = "h"
        case diamond = "d"
        case club = "c"
    }
    
    enum Ranks : String, generateAllCases {
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ten = "10"
        case eleven = "J"
        case twelve = "Q"
        case thirteen = "K"
        case ace = "A"
    }
    
    func isSameRank(_ nextCard : Card) -> Bool {
        return self.rank == nextCard.rank
    }
    
    func isSameSuit(_ nextCard : Card) -> Bool {
        return self.suit == nextCard.suit
    }
    
    func isNextRank(_ nextCard : Card) -> Bool {
        return self.rank.hashValue == nextCard.rank.hashValue + 1
    }
    
    func isAce() -> Bool {
        return self.rank == .ace
    }
    
    func changeSide() -> Card {
        if side == .back {
            side = .front
            return self
        }
        side = .back
        return self
    }
    
    func generateCardImg() -> UIImage {
        if self.side == .back {
        return UIImage(named : "card-back") ?? UIImage()
        }
        return UIImage(named : self.suit.rawValue + self.rank.rawValue) ?? UIImage()
    }
    
}

protocol generateAllCases : Hashable {
    static func cases() -> AnySequence<Self>
    static var allCases: [Self] { get }
}

extension generateAllCases {
    
    static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    static var allCases: [Self] {
        return Array(self.cases())
    }
}

extension Card : CustomStringConvertible, Comparable{
    static func <(lhs: Card, rhs: Card) -> Bool {
        return lhs.rank.hashValue < rhs.rank.hashValue
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.suit == rhs.suit && lhs.rank == rhs.rank
    }
    
    var description : String {
        return "\(self.suit.rawValue)\(self.rank.rawValue)"
    }
    
    
}

