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
                                               selector: #selector(currentOpenedDeckDoubleTapped),
                                               name: .doubleTappedOpenedDeck,
                                               object: nil)
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

    func getWholeStackDelegate() -> WholeStackDelegate {
        return self.stackManagers
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
    private var stackManagers: (WholeStackDelegate & Stackable)!
    private var foundationManager: (FoundationManageable & Stackable)!
    private var deckManager: DeckDelegate!

    @objc func currentOpenedDeckDoubleTapped(notification: Notification) {
        let ruleChecker = RuleChecker(foundationManager: foundationManager,
                                      stackManagers: stackManagers)
        guard let userInfo = notification.userInfo else {return}
        guard let fromView = userInfo["from"] else { return }

        if (fromView as? CardDeckView) != nil {
            let activatedCard = deckManager.lastOpenedCard()!
            if ruleChecker.isValidToMove(newCard: activatedCard) {
                ruleChecker.sendCardToStackUp(newCard: activatedCard)
                // gameDelegate는 activatedCard가 foundation으로 가야하는지 stack으로가야하는지 모르므로 ruleChecker에게 전달함
                deckManager.removePoppedCard()
            }
        }
        if let from = (fromView as? OneStack) {
            let column = from.column
            guard let stackColumn = column else { return }
            let activatedCard = stackManagers.lastCard(of: stackColumn)

            if ruleChecker.isValidToMove(newCard: activatedCard) {
                ruleChecker.sendCardToStackUp(newCard: activatedCard)
                stackManagers.removePoppedCard(of: stackColumn)
            }
        }
    }

    func shuffleDeck() {
        deckManager.shuffleDeck()
    }

}


