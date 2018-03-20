//
//  FoundationDeck.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 9..
//  Copyright © 2018년 Napster. All rights reserved.
//

import Foundation

class FoundationDeck: CardGameMoveAble {
    private var foundationDeck = Array.init(repeating: Deck(cards: [Card]()), count: 4)
    
    func pickCard(xIndex: Int, yIndex: Int) -> Card {
        return foundationDeck[xIndex].cards[yIndex]
    }
    
    func calculateEmptyPlace() -> Int? {
        return foundationDeck.index(where: { $0.isEmptyDeck() })
    }
    
    func calculateSameGroup(_ card: Card) -> Int? {
        for index in 0..<foundationDeck.count {
            if foundationDeck[index].isSameGroup(card) {
                return index
            }
        }
        return nil
    }
    
    func isContinuousCard(_ card: Card) -> Bool {
        for index in 0..<foundationDeck.count {
            guard let baseCard = foundationDeck[index].lastCard() else { return false }
            if baseCard.isSameSuit(card) && baseCard.isContinuousCardRankFoundation(card) {
                return true
            }
        }
        return false
    }
    
    func pushCard(card: Card, index: Int) {
        foundationDeck[index].pushCard(card)
        NotificationCenter.default.post(name: .pushFoundation, object: self, userInfo: [Notification.Name.cardLocation: index,
                                                                                        Notification.Name.cardName: card.getCardName()])
    }
    
    func popCard(xPoint: Int) {
        _ = foundationDeck[xPoint].popCard()
    }
    
    func lastCard(xIndex: Int) -> Card? {
        return foundationDeck[xIndex].lastCard()
    }
}

/*
 NotificationCenter.default.post(name: .cardName,
 object: self,
 userInfo: [Notification.Name.pushCardFoundationFromOpenDeck: index])
 */
