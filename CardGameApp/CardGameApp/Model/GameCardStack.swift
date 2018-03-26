//
//  CardStackPrint.swift
//  CardGame
//
//  Created by Mrlee on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

class GameCardStack: CardGameMoveAble {
    private (set) var cardStacksOfTable: [Deck]
    private var deck: Deck
    
    init(with deck: Deck) {
        self.cardStacksOfTable = [Deck]()
        self.deck = deck
        self.deck.shuffle()
    }

    func pickCard(xIndex: Int, yIndex: Int) -> Card {
        return cardStacksOfTable[xIndex].cards[yIndex]
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
        guard let lastCard = self.cardStacksOfTable[xPoint].lastCard() else { return }
        lastCard.flipCard()
        NotificationCenter.default.post(name: .flipCard, object: self, userInfo: [Notification.Name.cardLocation: xPoint,
                                                                                  Notification.Name.cardName: lastCard.getCardName()])
    }
    
    func calculateEmptyPlace() -> Int? {
        return self.cardStacksOfTable.index(where: { $0.isEmptyDeck() })
    }
    
    func pushCard(card: Card, index: Int) {
        self.cardStacksOfTable[index].pushCard(card)
        NotificationCenter.default.post(name: .pushCardGameStack, object: self, userInfo: [Notification.Name.cardLocation: index,
                                                                                           Notification.Name.cardName: card.getCardName()])
    }
    
    func lastCard(xIndex: Int) -> Card? {
        return cardStacksOfTable[xIndex].lastCard()
    }
    
    func calculateValidRule(_ card: Card) -> (xPoint: Int, yPoint: Int)? {
        for index in 0..<cardStacksOfTable.count {
            if let lastCard = cardStacksOfTable[index].lastCard() {
                if lastCard.isValid(card) && lastCard.isContinuousCardRankStack(card) {
                    return (index, cardStacksOfTable[index].cards.endIndex - 1)
                }
            }
        }
        return nil
    }
    
    func choicePlace(with card: Card) -> (xPoint: Int, yPoint: Int)? {
       return calculateValidRule(card)
    }
    
}
