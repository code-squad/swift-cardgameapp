//
//  Player.swift
//  CardGame
//
//  Created by oingbong on 2018. 8. 29..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class Player: CustomStringConvertible {
    private var cards: [Card] = []
    private var name: String
    
    init(_ cards: [Card], _ name: String) {
        self.cards = cards
        self.name = name
        self.cards.sort(by: <)
    }
    
    var description: String {
        return "\(self.name) \(self.cards)"
    }
    
    func findLargestNumber() -> Card {
        return self.cards.last!
    }
    
    func hands() -> (Hands, Card) {
        let (cardCounts, target) = duplicateCard()
        let hands = selectHands(with: cardCounts)
        return (hands, target)
    }
    
    /*
     target
     1. 빈카드를 생성할 수 없어서 임의로 생성
     2. 투페어 경우에는 더 큰 숫자가 target으로 설정되므로
     나중에 투페어끼리 비교시에는 더 큰 숫자로 비교 가능
     */
    private func duplicateCard() -> ([Int], Card) {
        var cardCounts = [Int]()
        var count = 0
        var target = Card(number: .ace, shape: .club)
        
        // 중복 숫자 찾아서 배열에 추가
        for index in 0..<self.cards.count {
            for subIndex in index + 1..<self.cards.count where self.cards[index] == self.cards[subIndex] {
                count += 1
                target = self.cards[index]
            }
            if count > 0 {
                cardCounts.append(count)
                count = 0
            }
        }
        
        return (cardCounts, target)
    }
    
    // 핸즈 선택
    private func selectHands(with cardCounts: [Int]) -> Hands {
        switch cardCounts {
        case _ where cardCounts.contains(3) :
            return Hands.fourcard
        case _ where cardCounts.contains(2) :
            return Hands.triple
        case _ where cardCounts.contains(1) :
            return cardCounts.count >= 2 ? Hands.twopair : Hands.onepair
        default:
            return Hands.nothing
        }
    }
    
}
