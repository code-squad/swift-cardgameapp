//
//  Card.swift
//  CardGame
//
//  Created by Mrlee on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

class Card: Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.suit == rhs.suit) && (lhs.rank == rhs.rank)
    }
    
    static func <(lhs: Card, rhs: Card) -> Bool {
        let lhsRank = lhs.rank
        let rhsRank = rhs.rank
        return Int(Card.Rank.allValues.index(of: lhsRank)!) < Int(Card.Rank.allValues.index(of: rhsRank)!)
    }
    
    private (set) var suit: Suit
    private (set) var rank: Rank
    // 열거형 자료형은 같은 개념의 자료들을 묶어 놓을때 사용합니다.
    // 그리고 Suit로 선언된 변수에 .rawValue를 사용하면 직접 값에 접근할 수 있어서 카드의 값을 구할때 사용하면 좋을 것 같습니다.
    enum Suit: String {
        case clubs = "♣️"
        case hearts = "❤️"
        case diamonds = "♦️"
        case spades = "♠️"
        static let allValues = [clubs, hearts, diamonds, spades]
    }
    enum Rank: String {
        case one = "A"
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
        static let allValues = [one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen]
    }
    
    init(suit: Int, rank: Int) {
        self.suit = Card.Suit.allValues[suit]
        self.rank = Card.Rank.allValues[rank]
    }
    
    func isOnePairRank(at index: Int) -> Bool {
        return rank.hashValue + 1 == index
    }
    
    func getCalculatedSuit() -> Int {
        return suit.hashValue + 1
    }
}

extension Card: CustomStringConvertible {
    var description: String {
        return suit.rawValue + rank.rawValue
    }
}
