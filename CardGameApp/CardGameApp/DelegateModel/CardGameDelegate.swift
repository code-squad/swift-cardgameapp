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
            stacks.append(oneStack)
        }

        self.stackManagers = WholeStackDelegate(stacks: stacks)
        self.foundationManager = FoundationDelegate()
        self.deckManager = DeckDelegate(deck: self.cardDeck)


        NotificationCenter.default.addObserver(self,
                                               selector: #selector(closedDeckTapped),
                                               name: .singleTappedClosedDeck,
                                               object: nil)
    }

    @objc func closedDeckTapped() {
        guard deckManager.hasEnoughCard()
        else {
            NotificationCenter.default.post(name: .openDeckUpdated, object: false)
            return
            }
        deckManager.pop()
        NotificationCenter.default.post(name: .openDeckUpdated, object: true)
    }

    class func shared() -> CardGameDelegate {
        return sharedCardDeck
    }

    class func restartSharedDeck() -> CardGameDelegate {
        sharedCardDeck = CardGameDelegate()
        return sharedCardDeck
    }

    func getWholeStackDelegate() -> (CardStackManageable & Stackable) {
        return self.stackManagers
    }

    func getFoundationDelegate() -> (FoundationManageable & Stackable) {
        return self.foundationManager
    }

    func getDeckDelegate() -> CardDeckManageable {
        return self.deckManager
    }

    // MARK: CardGameDelegate Related

    static let defaultStackRange: CountableClosedRange = 1...7
    static let defaultStackNumber: Int = 7
    private var cardDeck = CardDeck()
    private var stackManagers: (CardStackManageable & Stackable)!
    private var foundationManager: (FoundationManageable & Stackable)!
    private var deckManager: CardDeckManageable!

    func shuffleDeck() {
        deckManager.shuffleDeck()
    }

    func popOpenDeck() {
        deckManager.removePoppedCard()
    }

    func popStack(column: Int) {
        let activatedCard = stackManagers.lastCard(of: column)
        stackManagers.removePoppedCard(of: column)
    }

    func newRuleCheck(card: Card) -> (to: ViewKey, index: Int?) {
        if let tofoundationIndex = foundationManager.stackable(nextCard: card) {
            return (to: .foundation, index: tofoundationIndex)
        }
        else if let toStackIndex = stackManagers.stackable(nextCard: card) {
            return (to: .stack, index: toStackIndex)
        } else {
            return (to: .deck, index: nil)
        }
    }

    func movableFromDeck(from: ViewKey) -> (to: ViewKey, index: Int?) {
        guard from == .deck else { return (to: .deck, index: nil) }
        guard let newCard = deckManager.lastOpenedCard() else { return(to: .deck, index: nil) }
        return newRuleCheck(card: newCard)
    }

    func movableFromStack(from: ViewKey, column: Int) -> (to: ViewKey, index: Int?) {
        guard from == .fromStack else { return(to: .fromStack, index: nil) }
        let newCard = stackManagers.lastCard(of: column)
        return newRuleCheck(card: newCard)
    }
}

