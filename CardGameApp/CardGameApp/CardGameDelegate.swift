//
//  CardStackDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 19..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

protocol StackManageable {
    func makeStacks(numberOfCards: Int) -> [CardStack]
    func cardInturn(at index: (column: StackTable.RawValue, row: Int)) -> Card
    func countOfDeck() -> Int
    func pickACard() -> Card
    func shuffleDeck()
    func defaultstacks() -> [CardStack]
}


class CardGameDelegate: StackManageable {
    static let defaultStackRange: CountableClosedRange = 1...7
    static let defaultStackNumber: Int = 7

    private var cardDeck = CardDeck()
    private var cardStacks = [CardStack]()

    init() {
        cardDeck.shuffle()
        var stacks = [CardStack]()
        for numberOfCard in CardGameDelegate.defaultStackRange {
            let oneStack = cardDeck.makeStack(numberOf: numberOfCard)
            oneStack.sortDefaultStack()
            stacks.append(oneStack)
        }
        self.cardStacks = stacks
    }

    init(numberOfCards: Int) {
        cardDeck.shuffle()
        var stacks = [CardStack]()
        for _ in 0..<numberOfCards {
            let oneStack = cardDeck.makeStack(numberOf: numberOfCards)
            oneStack.sortDefaultStack()
            stacks.append(oneStack)
        }
        self.cardStacks = stacks
    }

    func makeStacks(numberOfCards: Int) -> [CardStack] {
        var stacks = [CardStack]()
        for _ in 0..<numberOfCards {
            let oneStack = cardDeck.makeStack(numberOf: numberOfCards)
            oneStack.sortDefaultStack()
            stacks.append(oneStack)
        }
        return stacks
    }

    func cardInturn(at index: (column: Int, row: Int)) -> Card {
        let chosenStack = self.cardStacks[index.column]
        return chosenStack.getCard(at: index.row)
    }

    func countOfDeck() -> Int {
        return cardDeck.count()
    }

    func pickACard() -> Card {
        return cardDeck.removeOne()
    }

    func shuffleDeck() {
        cardDeck.shuffle()
    }

    func defaultstacks() -> [CardStack] {
        return self.cardStacks
    }

}


