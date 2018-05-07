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

        self.stackManagers = WholeStackDelegate(stacks: stacks)
        self.foundationManager = FoundationDelegate()
        self.deckManager = DeckDelegate(deck: self.cardDeck)

        NotificationCenter.default.addObserver(self, selector: #selector(currentOpenedCardDoubleTapped), name: .doubleTappedOpenedDeck, object: nil)
    }

    class func shared() -> CardGameDelegate {
        return sharedCardDeck
    }

    class func restartSharedDeck() -> CardGameDelegate {
        sharedCardDeck = CardGameDelegate()
        return sharedCardDeck
    }

    func getStackDelegate(of column: Int) -> StackDelegate {
        return self.stackManagers.getStackDelegate(of: column)
    }

    func getFoundationDelegate() -> FoundationManageable {
        return self.foundationManager
    }

    func getDeckDelegate() -> DeckDelegate {
        return self.deckManager
    }

    // MARK: CardGameDelegate Related

    static let defaultStackRange: CountableClosedRange = 1...7
    static let defaultStackNumber: Int = 7
    private var cardDeck = CardDeck()
    private var stackManagers: WholeStackDelegate!
    private var foundationManager: FoundationManageable!
    private var deckManager: DeckDelegate!
    var openedDeck = [Card]()

    @objc func currentOpenedCardDoubleTapped() {
        self.ruleCheck()
    }

    func ruleCheck() {
        guard let openedCard = self.openedDeck.last else { return }
        if openedCard.isDenominationA() {
            self.foundationManager.stackUp(newCard: openedCard)
        } else {
            // check stacks
        }

    }


}


