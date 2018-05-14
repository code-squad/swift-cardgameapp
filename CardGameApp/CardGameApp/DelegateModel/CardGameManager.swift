//
//  CardStackDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 19..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class CardGameManager: CardGameDelegate {

    // MARK: Singleton Related

    private static var sharedCardDeck = CardGameManager()

    private init() {
        cardDeck.shuffle()
        var stacks = [CardStack]()
        for numberOfCard in CardGameManager.defaultStackRange {
            let oneStack = cardDeck.makeStack(numberOf: numberOfCard)
            stacks.append(oneStack)
        }

        self.stackManagers = WholeStackManager(stacks: stacks)
        self.foundationManager = FoundationManager()
        self.deckManager = DeckManager(deck: self.cardDeck)


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

    class func shared() -> CardGameManager {
        return sharedCardDeck
    }

    class func restartSharedDeck() -> CardGameManager {
        sharedCardDeck = CardGameManager()
        return sharedCardDeck
    }

    func getWholeStackDelegate() -> (CardStackDelegate & Stackable) {
        return self.stackManagers
    }

    func getFoundationDelegate() -> (FoundationDelegate & Stackable) {
        return self.foundationManager
    }

    func getDeckDelegate() -> CardDeckDelegate {
        return self.deckManager
    }

    // MARK: CardGameDelegate Related

    static let defaultStackRange: CountableClosedRange = 1...7
    static let defaultStackNumber: Int = 7
    private var cardDeck = CardDeck()
    private var stackManagers: (CardStackDelegate & Stackable)!
    private var foundationManager: (FoundationDelegate & Stackable)!
    private var deckManager: CardDeckDelegate!

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

