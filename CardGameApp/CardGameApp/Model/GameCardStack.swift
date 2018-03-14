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
        guard let _ = self.cardStacksOfTable[xPoint].popCard() else { return }
    }
    
    private func calculateEmptyPlace() -> Int? {
        return self.cardStacksOfTable.index(where: { $0.isEmptyDeck() } )
    }
    
    func pushKing(_ card: Card) -> Bool {
        guard let emptyIndex = calculateEmptyPlace() else { return false }
        self.cardStacksOfTable[emptyIndex].pushCard(card)
        return true
    }
    
    func pushCard(card: Card, index: Int) {
        self.cardStacksOfTable[index].pushCard(card)
    }
    
    func calculateValidRule(_ card: Card) -> Int? {
        for index in 0..<cardStacksOfTable.count {
            guard let lastCard = cardStacksOfTable[index].lastCard() else { return nil}
            if lastCard.isValid(card) && lastCard.isContinuousCardRank(card) {
                return index
            }
        }
        return nil
    }
    
    func choicePlace(with card: Card) -> Int? {
        return calculateValidRule(card)
    }
    
    
}
