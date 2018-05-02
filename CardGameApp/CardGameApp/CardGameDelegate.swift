//
//  CardStackDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 19..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

protocol CardGameManageable {
    var stackManagers: [StackDelegate] { get }
    func makeStacks(numberOfCards: Int) -> [CardStack]
    func cardInturn(at index: (column: StackTable.RawValue, row: Int)) -> ImageSelector
    func countOfDeck() -> Int
    func pickACard() -> Card
    func shuffleDeck()
    func stacks() -> [CardStack]
    func currentDeck() -> CardDeck
    func countOfStacks() -> Int
    func hasEnoughCard() -> Bool
    func countOfCards(column: Int) -> Int
}

protocol FoundationManageable {
    func makeEmptyFoundation()
    func addCard()
    func updateFoundation()
}

protocol StacksManageable {

}


class StackDelegate {
    private static var stackDelegates = [StackDelegate]()

    private var lastCard: Card!
    private var column: Int!
    private var stack: CardStack!

    init(oneStack: CardStack, column: Int) {
        self.stack = oneStack
        self.column = column
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


    // MARK: CardGameDelegate Related

    static let defaultStackRange: CountableClosedRange = 1...7
    static let defaultStackNumber: Int = 7
    private var cardDeck = CardDeck()
    private var cardStacks = [CardStack]()

    // StackDelegate배열을 computed property로 리턴
    var stackManagers: [StackDelegate] {
        var temp = [StackDelegate]()
        for column in 0..<self.cardStacks.count {
            temp.append(StackDelegate(oneStack: self.cardStacks[column], column: column))
        }
        return temp
    }

    // StackDelegate배열을 메소드로 리턴
    func makeStackDelegates() -> [StackDelegate]{
        var temp = [StackDelegate]()
        for column in 0..<self.cardStacks.count {
            temp.append(StackDelegate(oneStack: self.cardStacks[column], column: column))
        }
        return temp
    }

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

    func countOfStacks() -> Int {
        return self.cardStacks.count
    }

    func cardInturn(at index: (column: Int, row: Int)) -> ImageSelector {
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


