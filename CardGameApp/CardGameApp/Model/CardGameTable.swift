//
//  CardEvaluator.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 30..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation

protocol TableControl {
    mutating func setOpenedCard(_ card: Card)
    mutating func setCardStacks(_ cardStacks: [[Card]])
    mutating func moveCard(_ cardInfo: CardInfo) -> (isTrue : Bool, doubleTappedCard : Card)
    func getCardInfo(_ card: Card) -> CardInfo
}

struct CardGameTable : TableControl {
    private var foundation : [Card] = [] {
        didSet {
            NotificationCenter.default.post(name: .foundation, object: self, userInfo: [Key.Observer.foundation.name : self.foundation])
        }
    }
    private var cardStacks : [[Card]] = [] {
        didSet {
            NotificationCenter.default.post(name: .cardStacks, object: self, userInfo: [Key.Observer.cardStacks.name : self.cardStacks])
        }
    }
    private var openedCard : Card = Card(.spade, .two)
    
    mutating func setOpenedCard(_ card: Card) {
        self.openedCard = card
    }
    
    mutating func setCardStacks(_ cardStacks: [[Card]]) {
        self.cardStacks = cardStacks
    }
    
}

//Check Move & Hand
extension CardGameTable {
    
    mutating func moveCard(_ cardInfo: CardInfo) -> (isTrue : Bool, doubleTappedCard : Card) {
        let doubleTappedCard: Card
        if cardInfo.position == .top {
            doubleTappedCard = self.openedCard
            return (checkMove(doubleTappedCard, cardInfo), doubleTappedCard)
        }
        doubleTappedCard = self.cardStacks[cardInfo.indexOfCard][cardInfo.stackIndex]
        return (checkMove(doubleTappedCard, cardInfo), doubleTappedCard)
    }
    
    func getCardInfo(_ card: Card) -> CardInfo {
        var cardInfo : CardInfo!
        for index in self.foundation.indices {
            guard card == self.foundation[index] else { continue }
            cardInfo = CardInfo(index, Key.Card.noStack.count, .top)
            break
        }
        for index in self.cardStacks.indices {
            guard let stackIndex = self.cardStacks[index].index(where: {$0 == card}) else { continue }
            cardInfo = CardInfo(index, stackIndex, .cardStacks)
            break
        }
        return cardInfo
    }
    
    mutating private func checkMove(_ tappedCard: Card, _ tappedCardInfo: CardInfo) -> Bool {
        guard !tappedCard.isAce() else { return moveAce(tappedCard, tappedCardInfo) }
        guard !tappedCard.isKing() else { return moveKing(tappedCard, tappedCardInfo) }
        guard !moveFoundation(tappedCard, tappedCardInfo) else { return true }
        guard !moveStack(tappedCard, tappedCardInfo) else { return true }
        return false
    }
    
    mutating private func moveFoundation(_ card: Card, _ cardInfo: CardInfo) -> Bool {
        for index in self.foundation.indices {
            guard self.foundation[index].isSameSuit(card) && card.isNextRank(self.foundation[index]) else { continue }
            self.foundation[index] = card
            guard cardInfo.position == .cardStacks else { return true }
            self.cardStacks[cardInfo.indexOfCard].removeLast()
            return true
        }
        return false
    }
    
    mutating private func moveStack(_ card: Card, _ cardInfo: CardInfo) -> Bool {
        for index in self.cardStacks.indices {
            guard let lastCard = self.cardStacks[index].last else { return false }
            guard card.isDifferentColor(lastCard) && lastCard.isNextRank(card) else { continue }
            self.cardStacks[index].append(card)
            guard cardInfo.position == .cardStacks else { return true }
            self.cardStacks[cardInfo.indexOfCard].removeLast()
            return true
        }
        return false
    }
    
    mutating private func moveAce(_ card: Card, _ cardInfo: CardInfo) -> Bool {
        self.foundation.append(card)
        guard cardInfo.position == .cardStacks else { return true }
        self.cardStacks[cardInfo.indexOfCard].removeLast()
        return true
    }
    
    mutating private func moveKing(_ card: Card, _ cardInfo: CardInfo) -> Bool {
        for index in self.cardStacks.indices {
            guard self.cardStacks[index].count == 0 else { continue }
            self.cardStacks[index].append(card)
            guard cardInfo.position == .cardStacks else { return true }
            self.cardStacks[cardInfo.indexOfCard].removeLast()
            return true
        }
        return false
    }
}
