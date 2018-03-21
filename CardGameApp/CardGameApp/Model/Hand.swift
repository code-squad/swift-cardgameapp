//
//  PokerHand.swift
//  CardGame
//
//  Created by jack on 2018. 1. 12..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct Hand {
    
    var hand = HandName.noHand
    var pairVal : Card = Card.init(.spade, .two)
    private var straightVal = false
    private var royalVal = false
    private var TOKVal = false
    private var FOKVal = false
    private var flushVal = false
    private var countOfPair = 0
    
    init(_ userCards : [Card]) {
        self.straightVal = self.isStraight(userCards)
        self.flushVal = self.isFlush(userCards)
        countNumberOfSameRanks(userCards)
        self.hand = getHand()
    }
    
    enum HandName {
        case noHand
        case highCard
        case pair
        case twoPair
        case threeOfAKind
        case straight
        case flush
        case fullHouse
        case fourOfAKind
        case straightFlush
        case royalFlush
    }
    
    private func getHand() -> HandName {
        guard !(self.flushVal && self.royalVal) else { return HandName.royalFlush }
        guard !(self.straightVal && self.flushVal) else { return HandName.straightFlush }
        guard !self.FOKVal else { return HandName.fourOfAKind }
        guard !(self.TOKVal && self.countOfPair == 1) else { return HandName.fullHouse }
        guard !self.flushVal else { return HandName.flush }
        guard !self.straightVal else { return HandName.straight }
        guard !self.TOKVal else { return HandName.threeOfAKind }
        guard !(self.countOfPair == 2) else { return HandName.twoPair }
        guard !(self.countOfPair == 1) else { return HandName.pair }
        return HandName.highCard
    }
    
    mutating private func isStraight(_ userCards : [Card]) -> Bool {
        let cardsByRanks = userCards.sorted { $0 > $1 }
        var straightCounter = 0
        for indexOfCard in 0..<(cardsByRanks.count - 1) {
            guard cardsByRanks[indexOfCard].isNextRank(cardsByRanks[indexOfCard + 1]) else {
                continue
            }
            straightCounter += 1
        }
        if cardsByRanks[0].isAce() {
            self.royalVal = true
        }
        return straightCounter >= 5
    }
    
    private func isFlush(_ userCards : [Card]) -> Bool {
        for indexOfCard in 0..<(userCards.count - 1) {
            guard !userCards[indexOfCard].isSameSuit(userCards[indexOfCard + 1]) else {
                continue
            }
            return false
        }
        return true
    }
    
    
    mutating private func countNumberOfSameRanks(_ userCards : [Card])  {
        var sameRanks : [Card] = []
        for indexOfCard in 0..<userCards.count {
            var sameRankVal = 0
            for oneCard in userCards {
                guard userCards[indexOfCard].isSameRank(oneCard) else { continue }
                sameRankVal += 1
            }
            if sameRankVal == 2 && !sameRanks.contains(where: {$0.isSameRank(userCards[indexOfCard]) } ) {
                sameRanks.append(userCards[indexOfCard])
            }
            switch sameRankVal {
            case 2 : self.countOfPair = sameRanks.count
            case 3 : self.TOKVal = true
            case 4 : self.FOKVal = true
            default : break
            }
        }
        if sameRanks.count != 0 {
            self.pairVal = sameRanks.sorted { $0 > $1 }[0]
        }
    }
    
    func isSameHand(_ nextHand : Hand) -> Bool {
        return self.hand == nextHand.hand
    }
    
}
extension Hand : Comparable {
    
    static func <(lhs: Hand, rhs: Hand) -> Bool {
        if lhs.hand == rhs.hand {
            return lhs.pairVal < rhs.pairVal
        }
        return lhs.hand.hashValue < rhs.hand.hashValue
    }
    
    static func ==(lhs: Hand, rhs: Hand) -> Bool {
        return lhs.hand.hashValue == rhs.hand.hashValue
    }
    
}

