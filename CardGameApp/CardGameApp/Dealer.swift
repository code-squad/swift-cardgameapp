//
//  Dealer.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 7..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct Dealer: GamePlayer, GameOperator {
    private var deck : CardGameDeck = Deck()
    
    private let role = "딜러"
    private var cards : CardStack?
    
    var description: String {
        guard let cards = self.cards else {return ""}
        return "\(self.role) \(cards)"
    }
    
    mutating func distributeCard(gameType:Int, numberOfParticipant:Int) -> [GamePlayer] {
        var gamePlayers = [GamePlayer]()
        self.deck.shuffle()
        for number in 1...numberOfParticipant {
            gamePlayers.append(Participant.init(name: "참가자#\(number)",cards: deck.draw(few: gameType)))
        }
        self.cards = deck.draw(few: gameType)
        gamePlayers.append(self)
        return gamePlayers
    }
    
    func numberOfDeck() -> Int {
        return self.deck.count()
    }
    
    func score() -> Int {
        guard let cardStack = self.cards else {return 0}
        return ScoreCalculator.calculateScore(cardStack: cardStack)
    }
}

