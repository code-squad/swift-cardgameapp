//
//  CardStackDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 19..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

protocol CardGameManageable {
    func makeStacks(numberOfCards: Int) -> [CardStack]
    func countOfDeck() -> Int
    func pickACard() -> Card
    func shuffleDeck()
    func stacks() -> [CardStack]
    func currentDeck() -> CardDeck
    func hasEnoughCard() -> Bool
    func countOfCards(column: Int) -> Int
    func getStackDelegate(of column: Int) -> StackDelegate
}

protocol FoundationManageable {
    func makeEmptyFoundation()
    func stackUp(newCard: Card)
    func updateFoundation()
}

class StackDelegate {
    private static var stackDelegates = [StackDelegate]()

    private var lastCard: Card {
        return self.stack.last()!
    }
    private var column: Int!
    private var stack: CardStack!

    init(oneStack: CardStack, column: Int) {
        self.stack = oneStack
        self.column = column
    }

    func currentLastCard() -> Card {
        return self.lastCard
    }

    func isStackable(nextCard: Card) -> Bool {
        // 다음에 오는 카드(더블탭된 카드)가 숫자가 연속되고 색깔이 다른지 판단
        if nextCard < self.lastCard && nextCard != self.lastCard {
            return true
        } else {
            return false
        }
    }

    func stackUp(newCard: Card) {
        if self.isStackable(nextCard: newCard) {
            self.stack.stackUp(newCard: newCard)
        } else if self.stack.isEmpty() {
            self.stack.stackUp(newCard: newCard)
        }
    }

    func countOfCard() -> Int {
        return self.stack.count()
    }

    func cardInTurn(at index: Int) -> Card {
        return self.stack.getCard(at: index)
    }

}

class CardGameDelegate: CardGameManageable {

    // MARK: Singleton Related

    private static var sharedCardDeck = CardGameDelegate()

    private init() {
        cardDeck.shuffle()
        var stacks = [CardStack]()
        for numberOfCard in CardGameDelegate.defaultStackRange {
            let oneStack = cardDeck.makeStack(numberOf: numberOfCard)
            oneStack.sortDefaultStack()
            stacks.append(oneStack)
        }
        self.cardStacks = stacks
    }

    class func shared() -> CardGameDelegate {
        return sharedCardDeck
    }

    class func restartSharedDeck() -> CardGameDelegate {
        sharedCardDeck = CardGameDelegate()
        return sharedCardDeck
    }

    func getStackDelegate(of column: Int) -> StackDelegate {
        return StackDelegate(oneStack: self.cardStacks[column], column: column)
    }

    // MARK: CardGameDelegate Related

    static let defaultStackRange: CountableClosedRange = 1...7
    static let defaultStackNumber: Int = 7
    private var cardDeck = CardDeck()
    private var cardStacks = [CardStack]()

    func currentDeck() -> CardDeck {
        return self.cardDeck
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

    func countOfDeck() -> Int {
        return cardDeck.count()
    }

    var currentOpenedCard: Card?

    func pickACard() -> Card {
        self.currentOpenedCard = cardDeck.removeOne()
        return self.currentOpenedCard!
    }

    func shuffleDeck() {
        cardDeck.shuffle()
    }

    func stacks() -> [CardStack] {
        return self.cardStacks
    }

    func hasEnoughCard() -> Bool {
        if cardDeck.count() > 0 {
            return true
        } else {
            return false
        }
    }

    func countOfCards(column: Int) -> Int {
        return self.cardStacks[column].count()
    }


}


