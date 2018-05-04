//
//  CardStackDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 19..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

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
        var stackManagers = [StackDelegate]()
        for i in 0..<stacks.count {
            stackManagers.append(StackDelegate(oneStack: stacks[i], column: i))
        }
        self.stackManagers = stackManagers

    }

    class func shared() -> CardGameDelegate {
        return sharedCardDeck
    }

    class func restartSharedDeck() -> CardGameDelegate {
        sharedCardDeck = CardGameDelegate()
        return sharedCardDeck
    }

    func getStackDelegate(of column: Int) -> StackDelegate {
        return self.stackManagers[column]
    }

    // MARK: CardGameDelegate Related

    static let defaultStackRange: CountableClosedRange = 1...7
    static let defaultStackNumber: Int = 7
    private var cardDeck = CardDeck()
    private var stackManagers = [StackDelegate]()

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

    func currentOpen() -> Card? {
        return self.currentOpenedCard ?? nil // 옵셔널로 하고 그리는 곳에서 판단, 혹은 옵셔널로 처리 안할거면 모델에서 카드가 있는지업는지 판단
    }

    // currentOpenedCard가 옵셔널이므로 bool로 카드 유무를 판단하는 메소드 추가
    func hasOpenedCard() -> Bool {
        guard self.currentOpenedCard != nil else {
            return false
        }
        return true
    }

    func pickACard() -> Card {
        self.currentOpenedCard = cardDeck.removeOne()
        return self.currentOpenedCard!
    }

    func shuffleDeck() {
        cardDeck.shuffle()
    }

    func hasEnoughCard() -> Bool {
        if cardDeck.count() > 0 {
            return true
        } else {
            return false
        }
    }


}


