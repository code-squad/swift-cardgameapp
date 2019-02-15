//
//  Dealer.swift
//  CardGame
//
//  Created by 윤동민 on 07/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class Dealer : GameParticipate {
    private var deck: CardDeck
    
    init(of deck: CardDeck) {
        self.deck = deck
        super.init("딜러")
    }
    
    // 카드패를 사용자들에게 나누어줌
    func distributeCardToPlayer(to players: Players, by count: Int) {
        players.distributeCard(cardCount: count) { (cardCount : Int) -> [Card] in
            var playerCards : [Card] = []
            for _ in 0..<cardCount {
                guard let pickCard = deck.removeOne() else { return [] }
                playerCards.append(pickCard)
            }
            return playerCards
        }
    }
}
