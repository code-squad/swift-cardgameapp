//
//  ScoreChecker.swift
//  CardGame
//
//  Created by YOUTH on 2018. 1. 22..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct ScoreChecker {

    struct Hands: Comparable {
        private var pokerHands: PokerHands
        private var topCard: Card

        init(pokerHands: PokerHands, topCard: Card) {
            self.pokerHands = pokerHands
            self.topCard = topCard
        }

        static func <(lhs: ScoreChecker.Hands, rhs: ScoreChecker.Hands) -> Bool {
            return lhs.pokerHands.rawValue < rhs.pokerHands.rawValue
        }

        static func ==(lhs: ScoreChecker.Hands, rhs: ScoreChecker.Hands) -> Bool {
            return lhs.pokerHands.rawValue == rhs.pokerHands.rawValue
        }

        func score() -> Int {
            return (self.pokerHands.rawValue * self.topCard.weightedScore())
        }

        func checkNoPair() -> Bool {
            return self.pokerHands.rawValue == PokerHands.NoPair.rawValue
        }

    }

    enum PokerHands: Int {
        case NoPair = 0
        case OnePair = 100
        case ThreeOfAKind = 400
        case Straight = 500
        case Flush = 600
        case FullHouse = 700
        case FourOfAKind = 900
        case StraightFlush = 1500
    }

    private func isStraight(_ cards: [Card]) -> Bool {
        var count = 0
        for i in 1..<cards.count {
            if cards[i-1].isContinuous(next: cards[i]){
                count += 1
            }
        }
        return count >= 4
    }

    private func isFlush(_ cards: [Card]) -> Bool {
        let suitSets = cards.reduce(into: [CardDeck.Suit:[Card]]()) {
            $0[$1.shape(), default:[]].append($1)
        }
        for set in suitSets {
            if set.value.count == 5 {
                return true
            }
        }
        return false
    }

    // 내림차순 정렬된 cards배열을 받아서 스트레이트/플러시 검사
    private func matchStraightOrFlush(_ cards: [Card]) -> Hands {
        if isStraight(cards) && isFlush(cards) {
            return Hands(pokerHands: .StraightFlush, topCard: cards[0])
        }
        if isFlush(cards) && (isStraight(cards) == false) {
            return Hands(pokerHands: .Flush, topCard: cards[0])
        }
        if isStraight(cards) && (isFlush(cards) == false) {
            return Hands(pokerHands: .Straight, topCard: cards[0])
        }
        return Hands(pokerHands: .NoPair, topCard: cards[0])
    }

    private func matchPairs(_ cards: [Card]) -> [Hands] {
        let pairCheck = cards.reduce(into: [Card: [Card]]()) {
            $0[$1, default: []].append($1)
        }
        var handsSet = [Hands]()
        var hands = Hands(pokerHands: .NoPair, topCard: cards[0])
        var pokerHands = [PokerHands]() // FullHouse검사용 배열

        pairCheck.forEach {
            switch $0.value.count {
            case 4:
                let sortedCards = $0.value.sorted(by: >)
                hands = Hands(pokerHands: .FourOfAKind, topCard: sortedCards[0])
                handsSet.append(hands)

                pokerHands.append(.FourOfAKind)
            case 3:
                // ThreeOfAKind를 추가하는 경우 기존Hands에 Onepair가 있으면 FullHouse이므로, case 안에서 검사함
                // 기존에 있던 OnePair까지 점수가 계산되지 않게 FullHouse를 가진 Hands로 바꿈
                if pokerHands.contains(.OnePair) {
                    let index = pokerHands.index(of: .OnePair)!
                    handsSet.remove(at: index)

                    let sortedCards = $0.value.sorted()
                    hands = Hands(pokerHands: .FullHouse, topCard: sortedCards[0])
                    handsSet.append(hands)
                    pokerHands.append(.FullHouse)

                } else {
                    let sortedCards = $0.value.sorted()
                    hands = Hands(pokerHands: .ThreeOfAKind, topCard: sortedCards[0])
                    handsSet.append(hands)
                    pokerHands.append(.ThreeOfAKind)
                }
            case 2:
                // Onepair인 경우에도 마찬가지로 기존Hands에 ThreeOfAKind가 있으면 FullHouse이므로, case 안에서 검사함
                // 기존에 있던 ThreeOfAKind까지 점수가 계산되지 않게 FullHouse를 가진 Hands로 바꿈
                if pokerHands.contains(.ThreeOfAKind) {
                    let index = pokerHands.index(of: .ThreeOfAKind)!
                    handsSet.remove(at: index)

                    let sortedCards = $0.value.sorted()
                    hands = Hands(pokerHands: .FullHouse, topCard: sortedCards[0])
                    handsSet.append(hands)
                    pokerHands.append(.FullHouse)

                } else {
                    let sortedCards = $0.value.sorted()
                    hands = Hands(pokerHands: .OnePair, topCard: sortedCards[0])
                    handsSet.append(hands)
                    pokerHands.append(.OnePair)
                }
            default:
                // NoPair의 경우 탑카드는 파라미터 cards배열 중의 가장 큰 수의 카드.
                let sortedCards = cards.sorted()
                hands = Hands(pokerHands: .NoPair, topCard: sortedCards[0])
                handsSet.append(hands)
                pokerHands.append(.NoPair)
            }
        }
        return handsSet
    }

    // 사용자의 패 결과(Hands)가 모두 NoPair인 경우를 검사해서 Bool 리턴
    private func noPairOnly(_ pokerHands: [Hands]) -> Bool {
        var count = 0
        for oneHands in pokerHands {
            if oneHands.checkNoPair() {
                count += 1
            }
        }
        return count == pokerHands.count
    }

    // 최종 집계점수 계산
    func totalScore(cardStack: CardStack) -> Int {
        let cards = cardStack.sort(order: .Descending)
        var pokerHands = [Hands]()
        var score = 0

        // 하나의 카드 스택 당 스트레이트, 플러시 검사와 페어 검사를 둘 다 해서 [Hands] 생성
        pokerHands.append(matchStraightOrFlush(cards))
        pokerHands += matchPairs(cards)

        // 모든 Hands의 결과가 NoPair인 경우 base score인 1점에 탑카드 가중치 점수를 곱한다.
        if noPairOnly(pokerHands) {
            let noPairScore = 1
            return noPairScore * cards[0].weightedScore()
        }
        for oneHands in pokerHands {
            score += oneHands.score()
        }
        return score
    }

}
