//
//  ScoreCalculator.swift
//  CardGame
//
//  Created by 윤지영 on 20/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct ScoreCalculator {

    static private func count(_ rank: Rank, in cards: [Card]) -> Int? {
        var count = 0
        for card in cards {
            if card.hasSame(rank) {
                count += 1
            }
        }
        guard count != 0 else { return nil }
        return count
    }

    static private func countRank(of cards: [Card]) -> [Rank: Int] {
        var numberOfRanks: [Rank: Int] = [:]
        for rank in Rank.allCases {
            guard let count = count(rank, in: cards) else { continue }
            numberOfRanks[rank] = count
        }
        return numberOfRanks
    }

    static private func getBestSuit(paredWith rank: Rank, in cards: [Card]) -> Suit? {
        let suits = cards.compactMap { $0.hasSame(rank) ? $0 : nil }
        guard let cardWithBestSuit = suits.max() else { return nil }
        for suit in Suit.allCases {
            if cardWithBestSuit.hasSame(suit) {
                return suit
            }
        }
        return nil
    }

    static private func getTwoPair(in hands: [Hand]) -> Hand? {
        let onePairs = hands
            .compactMap { $0.ranking == Hand.onePair($0.rank, $0.suit).ranking ? $0 : nil }
        guard onePairs.count > 1 else { return nil }
        guard let higherOnePair = onePairs.max() else { return nil }
        return Hand.twoPair(higherOnePair.rank, higherOnePair.suit)
    }

    static private func makeHands(from cards: [Card]) -> [Hand] {
        let numberOfRanks: [Rank: Int] = countRank(of: cards)
        var hands: [Hand] = []
        for rankAndCount in numberOfRanks {
            let rank = rankAndCount.key
            guard let suit = getBestSuit(paredWith: rank, in: cards) else { continue }
            switch rankAndCount.value {
            case 4: hands.append(Hand.fourOfAKind(rank, suit))
            case 3: hands.append(Hand.threeOfAKind(rank, suit))
            case 2: hands.append(Hand.onePair(rank, suit))
            case 1: hands.append(Hand.highCard(rank, suit))
            default: continue
            }
        }
        if let twoPair = getTwoPair(in: hands) {
            hands.append(twoPair)
        }
        return hands
    }

    static func getBestHand(from cards: [Card]) -> Hand? {
        let hands = makeHands(from: cards)
        guard let bestHand = hands.max() else { return nil }
        return bestHand
    }

}
