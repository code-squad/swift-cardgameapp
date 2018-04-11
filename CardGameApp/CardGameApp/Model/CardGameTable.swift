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
            NotificationCenter.default.post(name: .foundation, object: self, userInfo: [Key.Observer.foundation.name : foundation])
        }
    }
    private var cardStacks : [[Card]] = [] {
        didSet {
            NotificationCenter.default.post(name: .cardStacks, object: self, userInfo: [Key.Observer.cardStacks.name : cardStacks])
        }
    }
    private var openedCard : Card = Card(.spade, .two)
    
    mutating func setOpenedCard(_ card: Card) {
        openedCard = card
    }
    
    mutating func setCardStacks(_ newCardStacks: [[Card]]) {
        cardStacks = newCardStacks
    }
    
}

//Check Move & Hand
extension CardGameTable {
    
    mutating func moveCard(_ cardInfo: CardInfo) -> (isTrue : Bool, doubleTappedCard : Card) {
        let doubleTappedCard: Card
        if cardInfo.position == .top {
            doubleTappedCard = openedCard
            return (checkMove(doubleTappedCard, cardInfo), doubleTappedCard)
        }
        doubleTappedCard = cardStacks[cardInfo.indexOfCard][cardInfo.stackIndex]
        return (checkMove(doubleTappedCard, cardInfo), doubleTappedCard)
    }
    
    func getCardInfo(_ card: Card) -> CardInfo {
        var cardInfo : CardInfo!
        for index in foundation.indices {
            guard card == foundation[index] else { continue }
            cardInfo = CardInfo(index, Key.Card.noStack.count, .top)
            break
        }
        for index in cardStacks.indices {
            guard let stackIndex = cardStacks[index].index(where: {$0 == card}) else { continue }
            cardInfo = CardInfo(index, stackIndex, .cardStacks)
            break
        }
        return cardInfo
    }
    
    mutating private func checkMove(_ tappedCard: Card, _ tappedCardInfo: CardInfo) -> Bool {
        switch tappedCard {
        case _ where tappedCard.isAce() : return moveAce(tappedCard, tappedCardInfo)
        case _ where tappedCard.isKing() : return moveKing(tappedCard, tappedCardInfo)
        case _ where moveFoundation(tappedCard, tappedCardInfo) || moveStack(tappedCard, tappedCardInfo) : return true
        default:
            return false
        }
    }
    
    mutating private func moveFoundation(_ card: Card, _ cardInfo: CardInfo) -> Bool {
        for index in foundation.indices {
            guard foundation[index].isSameSuit(card) && card.isNextRank(foundation[index]) else { continue }
            foundation[index] = card
            guard cardInfo.position == .cardStacks else { return true }
            cardStacks[cardInfo.indexOfCard].removeLast()
            return true
        }
        return false
    }
    
    mutating private func moveStack(_ card: Card, _ cardInfo: CardInfo) -> Bool {
        for index in cardStacks.indices {
            guard let lastCard = cardStacks[index].last else { return false }
            guard card.isDifferentColor(lastCard) && lastCard.isNextRank(card) else { continue }
            cardStacks[index].append(card)
            guard cardInfo.position == .cardStacks else { return true }
            cardStacks[cardInfo.indexOfCard].removeLast()
            return true
        }
        return false
    }
    
    mutating private func moveAce(_ card: Card, _ cardInfo: CardInfo) -> Bool {
        foundation.append(card)
        guard cardInfo.position == .cardStacks else { return true }
        cardStacks[cardInfo.indexOfCard].removeLast()
        return true
    }
    
    mutating private func moveKing(_ card: Card, _ cardInfo: CardInfo) -> Bool {
        for index in cardStacks.indices {
            guard cardStacks[index].count == 0 else { continue }
            cardStacks[index].append(card)
            guard cardInfo.position == .cardStacks else { return true }
            cardStacks[cardInfo.indexOfCard].removeLast()
            return true
        }
        return false
    }
}
