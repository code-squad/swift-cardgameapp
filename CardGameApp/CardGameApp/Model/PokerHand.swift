//
//  CalculatePoint.swift
//  CardGame
//
//  Created by Mrlee on 2017. 12. 8..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct PokerHand {
    enum PokerRank: Int {
        case noHands
        case highCard = 100
        case onePair = 200
        case twoPair = 400
        case threeOfKind = 450
        case straight = 500
        case royalStraight = 600
        case flush = 700
        case fullhouse = 850
        case fourOfKind = 900
        case straightFlush = 1000
        case royalStraightFlush = 1100
    }
    
    func makePokerHandRanking(_ cards: [[Card]]) -> (hand: [PokerRank], score: [Int]) {
        var resultOfHand = [PokerRank]()
        var resultOfPoint = [Int]()
        for cardStack in cards {
            let result = sortStackOfPlayer(cardStack)
            resultOfHand.append(result.0)
            resultOfPoint.append(result.1)
        }
        return (resultOfHand, resultOfPoint)
    }
    
    private func sortStackOfPlayer(_ stack: [Card]) -> (PokerRank, Int) {
        var pointTable = Array(repeating: 0, count: 14)
        for i in 0..<stack.count {
            let value = stack[i].rank.rawValue
            if value == "A" {
                pointTable[1] += 1
            } else if value == "J" {
                pointTable[11] += 1
            } else if value == "Q" {
                pointTable[12] += 1
            } else if value == "K" {
                pointTable[13] += 1
            } else {
                pointTable[Int(value)!] += 1
            }
        }
        return selectPokerHand(table: pointTable, cards: stack)
    }
    
    private func separateRowHand(table: [Int], cards stack: [Card]) -> (hand: Int, point: Int) {
        var resultOfHand = 0
        var point = 0
        for index in 1..<table.count {
            if table[index] == 2 {
                point += index * 2 + calculateOnePair(tableIndex: index, cards: stack)
                resultOfHand += PokerRank.onePair.rawValue
            }
            if table[index] == 3 {
                point += index * 3
                resultOfHand += PokerRank.threeOfKind.rawValue
            }
            if table[index] == 4 {
                point += index * 4
                resultOfHand += PokerRank.fourOfKind.rawValue
            }
        }
        return (resultOfHand, point)
    }
    
    private func calculateOnePair(tableIndex index: Int, cards stack: [Card]) -> Int {
        var point = 0
        for i in 0..<stack.count {
            if stack[i].isOnePairRank(at: index) {
                point += stack[i].getCalculatedSuit()
            }
        }
        return point
    }
    
    private func calculateHighCard(_ stack: [Card]) -> Int {
        let sortedCard = stack.sorted(by: <)
        var point = 0
        let hightCard = sortedCard[sortedCard.index(before: sortedCard.endIndex)]
        switch hightCard.rank {
        case .one:
            point += 1
        case .eleven:
            point += 11
        case .twelve:
            point += 12
        case .thirteen:
            point += 13
        default:
            point += Int(hightCard.rank.rawValue)!
        }
        
        for suitIndex in 0..<Card.Suit.allValues.count {
            if Card.Suit.allValues[suitIndex] == hightCard.suit {
                point += suitIndex + 1
            }
        }
        return point
    }
    
    private func separateHighHand(table: [Int], cards stack:[Card]) -> (PokerRank, Int)? {
        let flush = calculateFlushType(of: stack)
        let Straight = calculateStraight(of: table)
        if (flush.hand != PokerRank.noHands) && (Straight == PokerRank.straight) {
            return (PokerRank.straightFlush, PokerRank.straightFlush.rawValue + flush.point)
        } else if (flush.hand != PokerRank.noHands) && (Straight == PokerRank.royalStraight) {
            return (PokerRank.royalStraightFlush, 0)
        }
        if (flush.hand != PokerRank.noHands && Straight == PokerRank.noHands) {
            return (PokerRank.flush, PokerRank.straightFlush.rawValue + flush.point)
        }
        if (flush.hand == PokerRank.noHands && Straight != PokerRank.noHands) {
            return (Straight, 0) // Straigth Or Royal Straight
        }
        return nil
    }
    
    private func selectPokerHand(table pointTable: [Int], cards stack:[Card]) -> (PokerRank, Int) {
        let resultScore = separateRowHand(table: pointTable, cards: stack)

        switch resultScore.hand {
        case PokerRank.onePair.rawValue:
            return (PokerRank.onePair, PokerRank.onePair.rawValue + resultScore.point)
        case PokerRank.threeOfKind.rawValue:
            return (PokerRank.threeOfKind, PokerRank.threeOfKind.rawValue + resultScore.point)
        case PokerRank.onePair.rawValue + PokerRank.onePair.rawValue:
            return (PokerRank.twoPair, PokerRank.twoPair.rawValue + resultScore.point)
        case PokerRank.onePair.rawValue + PokerRank.threeOfKind.rawValue:
            return (PokerRank.fullhouse, PokerRank.fullhouse.rawValue)
        case PokerRank.fourOfKind.rawValue:
            return (PokerRank.fourOfKind, PokerRank.fourOfKind.rawValue + resultScore.point)
        default:
            // resultScore.hand의 값이 0이란것은 스트레이트 이거나, highCard 라는 뜻, 밑의 바인딩을 통해 높은 hand의 패가 아니면 highCard로 return
            if let highScoreHand = separateHighHand(table: pointTable, cards: stack) {
                return highScoreHand
            }
            return (PokerRank.highCard, calculateHighCard(stack))
        }
    }
    
    private func calculateStraight(of pointTable: [Int]) -> PokerRank {
        var cardValue = 0
        for index in 1..<pointTable.count {
            if cardValue == 5 { break }
            if pointTable[index] == 1 {
                cardValue += 1
            } else if pointTable[index] == 0 && cardValue != 0 {
                cardValue = 0
            }
        }
        if cardValue == 4 && pointTable[1] == 1 {
            return PokerRank.royalStraight
        }
        if cardValue == 5 {
            return PokerRank.straight
        }
        return PokerRank.noHands
    }
    
    private func calculateFlushType(of stack: [Card]) -> (hand: PokerRank, point: Int) {
        if let frushSuitIndex = countSuit(stack).index(of: 5) {
            return (PokerRank.flush, (Int(frushSuitIndex) + 1))
        }
        return (PokerRank.noHands, 0)
    }
    
    private func countSuit(_ stack: [Card]) -> [Int] {
        var countOfSuit = [0,0,0,0]
        for card in stack {
            switch card.suit {
            case .spades:
                countOfSuit[3] += 1
            case .diamonds:
                countOfSuit[2] += 1
            case .hearts:
                countOfSuit[1] += 1
            case .clubs:
                countOfSuit[0] += 1
            }
        }
        return countOfSuit
    }
}
