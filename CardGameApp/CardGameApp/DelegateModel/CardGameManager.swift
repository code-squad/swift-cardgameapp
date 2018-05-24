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

    // MARK: DoubleTap Action Related

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

    // MARK: Drag Action Related

    // update model하고 Bool리턴
    func ruleCheck(fromInfo: MoveInfo, toInfo: MoveInfo?) -> Bool {
        guard let movableCards = self.movableCards(info: fromInfo) else { return false }
        guard let to = toInfo else { return false }
        guard isStackAble(cards: movableCards, to: to) else { return false }
        guard removeCards(fromInfo: fromInfo) else { return false }
        return true
    }

    // MoveInfo에서 알려주는 뷰, column, index로 움직이는 대상 [Card]를 구함
    func movableCards(info: MoveInfo) -> [Card]? {
        switch info.getView().convertViewKey() {
        case .deck:
            guard let card = deckManager.lastOpenedCard() else { return nil }
            return [card]
        case .foundation:
            guard let column = info.getColumn() else { return nil }
            return foundationManager.cards(in: column)
        case .stack:
            guard let column = info.getColumn() else { return nil }
            guard let index = info.getIndex() else { return nil }
            return stackManagers.getStackDelegate(of: column).movableCards(from: index)
        default: return nil
        }
    }

    // toInfo에 [Card]가 stackable한지 검사 후 모델 업데이트
    func isStackAble(cards: [Card], to toInfo: MoveInfo) -> Bool {
        switch toInfo.getView().convertViewKey() {
        case .deck:
            return false
        case .foundation:
            guard let column = foundationManager.stackable(nextCard: cards[0]) else { return false }
            foundationManager.stackUp(newCard: cards[0], newCards: nil, column: column)
            return true
        case .stack:
            guard let availableStack = stackManagers.stackable(nextCard: cards[0]) else { return false }
            guard let toColumn = toInfo.getColumn() else { return false }
            guard availableStack == toColumn else { return false }
            stackManagers.stackUp(newCard: nil, newCards: cards, column: availableStack)
            return true
        default: return false
        }
    }

    // fromInfo에서 다른 곳으로 옯겨진 카드제거 후 성공시 true리턴
    private func removeCards(fromInfo from: MoveInfo) -> Bool {
        switch from.getView().convertViewKey() {
        case .deck:
            deckManager.removePoppedCard()
            return true
        case .foundation:
            return false
        case .stack:
            stackManagers.getStackDelegate(of: from.getColumn()!).removeCards(from: from.getIndex()!)
            return true
        default: return false
        }
    }


}

