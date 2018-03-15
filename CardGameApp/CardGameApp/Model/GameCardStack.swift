//
//  CardStackPrint.swift
//  CardGame
//
//  Created by Mrlee on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

class GameCardStack {
    private (set) var cardStacksOfTable: [Deck]
    private var deck: Deck
    
    init(with deck: Deck) {
        self.cardStacksOfTable = [Deck]()
        self.deck = deck
        self.deck.shuffle()
    }

    func startCardGame() throws -> Deck {
        for index in 1...7 {
            guard let playerStack = try? self.deck.makeStack(numberOfCards: index) else {
                throw ErrorCode.zeroCard
            }
            playerStack.lastCard()?.flipCard()
            cardStacksOfTable.append(playerStack)
        }
        return self.deck
    }
    
    func popCard(xPoint: Int) {
        guard self.cardStacksOfTable[xPoint].popCard() != nil else { return }
        NotificationCenter.default.post(name: .popCardGameStack, object: self, userInfo: [Notification.Name.cardLocation: xPoint])
        guard let lastCard = self.cardStacksOfTable[xPoint].lastCard() else { return }
        lastCard.flipCard()
        NotificationCenter.default.post(name: .flipCard, object: self, userInfo: [Notification.Name.cardLocation: xPoint,
                                                                                  Notification.Name.cardName: lastCard.getCardName()])
    }
    
    private func calculateEmptyPlace() -> Int? {
        return self.cardStacksOfTable.index(where: { $0.isEmptyDeck() })
    }
    
    func pushKing(_ card: Card) -> Bool {
        guard let emptyIndex = calculateEmptyPlace() else { return false }
        self.cardStacksOfTable[emptyIndex].pushCard(card)
        NotificationCenter.default.post(name: .pushCardGameStack, object: self, userInfo: [Notification.Name.cardLocation: emptyIndex,
                                                                                           Notification.Name.cardName: card.getCardName()])
        return true
    }
    
    func pushCard(card: Card, index: Int) {
        self.cardStacksOfTable[index].pushCard(card)
        NotificationCenter.default.post(name: .pushCardGameStack, object: self, userInfo: [Notification.Name.cardLocation: index,
                                                                                           Notification.Name.cardName: card.getCardName()])
    }
    
    func calculateValidRule(_ card: Card) -> Int? {
        for index in 0..<cardStacksOfTable.count {
            if let lastCard = cardStacksOfTable[index].lastCard() {
                if lastCard.isValid(card) && lastCard.isContinuousCardRankStack(card) {
                    return index
                }
            }
        }
        return nil
    }
    
    func choicePlace(with card: Card) -> Int? {
        return calculateValidRule(card)
    }
    
}
