//
//  CardEvaluator.swift
//  CardGameApp
//
//  Created by 권재욱 on 2018. 3. 30..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation

struct CardEvaluator {
    private var foundation : [Card] = []
    private var openedCard : Card = Card(.spade, .two)
    private var cardStacks : [[Card]] = []
    
    mutating func setOpenedCard(_ card: Card) {
        self.openedCard = card
    }
    
    mutating func setCardStacks(_ cardStacks: [[Card]]) {
        self.cardStacks = cardStacks
    }
    
    mutating func didMoveCard(_ cardInfo: CardInfo) -> Bool {
        let doubleTappedCard: Card
        if cardInfo.position == .top {
            doubleTappedCard = self.openedCard
            return checkHand(doubleTappedCard, cardInfo)
        }
        doubleTappedCard = self.cardStacks[cardInfo.indexOfCard][cardInfo.stackIndex]
        return checkHand(doubleTappedCard, cardInfo)
    }
    
    mutating private func checkHand(_ tappedCard: Card, _ tappedCardInfo: CardInfo) -> Bool {
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
            NotificationCenter.default.post(name: .foundation, object: self, userInfo: [Key.Observer.foundation.name:self.foundation])
            guard cardInfo.position == .cardStacks else { return true }
            self.cardStacks[cardInfo.indexOfCard].removeLast()
            NotificationCenter.default.post(name: .cardStacks, object: self, userInfo:[Key.Observer.cardStacks.name:self.cardStacks])
            return true
        }
        return false
    }
    
    mutating private func moveStack(_ card: Card, _ cardInfo: CardInfo) -> Bool {
        for index in self.cardStacks.indices {
            guard let lastCard = self.cardStacks[index].last else { return false }
            guard card.isDifferentColor(lastCard) && lastCard.isNextRank(card) else { continue }
            self.cardStacks[index].append(card)
            NotificationCenter.default.post(name: .cardStacks, object: self, userInfo:[Key.Observer.cardStacks.name:self.cardStacks])
            guard cardInfo.position == .cardStacks else { return true }
            self.cardStacks[cardInfo.indexOfCard].removeLast()
            NotificationCenter.default.post(name: .cardStacks, object: self, userInfo:[Key.Observer.cardStacks.name:self.cardStacks])
            return true
        }
        return false
    }
    
    mutating private func moveAce(_ card: Card, _ cardInfo: CardInfo) -> Bool {
        self.foundation.append(card)
        NotificationCenter.default.post(name: .foundation, object: self, userInfo: [Key.Observer.foundation.name:self.foundation])
        guard cardInfo.position == .cardStacks else { return true }
        self.cardStacks[cardInfo.indexOfCard].removeLast()
        NotificationCenter.default.post(name: .cardStacks, object: self, userInfo:[Key.Observer.cardStacks.name:self.cardStacks])
        return true
    }
    
    mutating private func moveKing(_ card: Card, _ cardInfo: CardInfo) -> Bool {
        for index in self.cardStacks.indices {
            guard self.cardStacks[index].count == 0 else { continue }
            self.cardStacks[index].append(card)
            NotificationCenter.default.post(name: .cardStacks, object: self, userInfo:[Key.Observer.cardStacks.name:self.cardStacks])
            guard cardInfo.position == .cardStacks else { return true }
            self.cardStacks[cardInfo.indexOfCard].removeLast()
            NotificationCenter.default.post(name: .cardStacks, object: self, userInfo:[Key.Observer.cardStacks.name:self.cardStacks])
            return true
        }
        return false
    }
    
}
