//
//  ParticipatablePlayer.swift
//  CardGame
//
//  Created by 윤동민 on 10/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum CardRule: Int {
    case noPair = 0
    case onePair = 1
    case twoPair = 2
    case tripple = 3
    case fourCard = 4
}

extension GameParticipate: Comparable {
    static func < (lhs: GameParticipate, rhs: GameParticipate) -> Bool {
        if lhs.state.rawValue < rhs.state.rawValue { return true }
        return false
    }
    
    static func == (lhs: GameParticipate, rhs: GameParticipate) -> Bool {
        if lhs.state == rhs.state { return true }
        return false
    }
}

class GameParticipate {
    var cards: [Card]
    var name: String
    var state: CardRule
    
    init(_ name: String) {
        cards = []
        self.name = name
        self.state = .noPair
    }

    func receiveCard(_ cards: [Card]) {
        self.cards = cards
    }
    
    func judgeMyCard(method: ([Card]) -> CardRule) {
        state = method(cards)
    }
    
    func searchHighNumberCard() -> Int {
        var highNumberCard = cards[0].number.rawValue
        for card in cards {
            if card.number.rawValue > highNumberCard { highNumberCard = card.number.rawValue }
        }
        return highNumberCard
    }
}

