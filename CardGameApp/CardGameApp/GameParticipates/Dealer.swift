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
    private var cardsMenu: ChoiceMenu?
    private var playersMenu: ChoiceParticipate?
    
    init(of deck: CardDeck) {
        self.deck = deck
        super.init("딜러")
    }
    
    func setGameMenu(_ cardMenu: ChoiceMenu) {
        self.cardsMenu = cardMenu
    }
    
    func setPlayersMenu(_ playersMenu: ChoiceParticipate) {
        self.playersMenu = playersMenu
    }
    
    func isSetMenu() -> Bool {
        guard cardsMenu != nil else { return false }
        guard playersMenu != nil else { return false }
        return true
    }
    
    // 카드패를 사용자들에게 나누어줌
    func distributeCardToPlayer(to players: Players) {
        guard let cardMenu = self.cardsMenu else { return }
        players.distributeCard(cardCount: cardMenu.rawValue) { (cardCount : Int) -> [Card] in
            var playerCards : [Card] = []
            for _ in 0..<cardCount {
                guard let pickCard = deck.removeOne() else { return [] }
                playerCards.append(pickCard)
            }
            return playerCards
        }
    }
}
