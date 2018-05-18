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

    // update model하고 Bool리턴
    func ruleCheck(fromInfo: MoveInfo, toInfo: MoveInfo) -> Bool {
        //카드구함
        //카드로 toInfo에 있는 뷰와 인덱스로 가는것이 적합한지 검사
        //검사 후 리턴값이 true면 movableCards 리턴/아니면 nil리턴
        guard let movableCards: [Card] = self.movableCards(info: fromInfo) else { return false }
        return  checkStackAble(card: movableCards, to: toInfo)
    }

    func movableCards(info: MoveInfo) -> [Card]? {
        switch info.getView().convertViewKey() {
        case .deck:
            return [deckManager.lastOpenedCard()!]
        case .foundation:
            return foundationManager.cards(in: 0)
        case .stack:
            return stackManagers.getStackDelegate(of: info.getColumn()!).movableCards(from: info.getIndex()!)
        default: return nil
        }
    }

    func checkStackAble(card: [Card], to toInfo: MoveInfo) -> Bool {
        switch toInfo.getView().convertViewKey() {
        case .deck:
            return false
        case .foundation:
            guard let column = foundationManager.stackable(nextCard: card[0]) else { return false }
            foundationManager.stackUp(newCard: card[0], newCards: nil, column: column)
            return true
        case .stack:
            // 모델에서 받아온 가능한 스택column
            guard let availableStack = stackManagers.stackable(nextCard: card[0]) else { return false }
            // toInfo에서 받아온 유저가 선택한 스택 column
            guard let toColumn = toInfo.getColumn() else { return false }
            // 모델에서 받아온 가능한 column과 유저가 선택한 column이 일치하는지 검사
            guard availableStack == toColumn else { return false }
            //모델변경
            stackManagers.stackUp(newCard: nil, newCards: card, column: availableStack)
            return true
        default: return false
        }
        return false
    }


}

