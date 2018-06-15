//
//  Deck.swift
//  CardGame
//
//  Created by Jung seoung Yeo on 2018. 5. 20..
//  Copyright © 2018년 JK. All rights reserved.
//
import Foundation

struct Deck {
    
    private var deck: [Card]!
    
    init() {
        self.reset()
    }
    
    // 카드의 갯수를 리턴하는 함수
    func count() -> Int{
        return deck.count
    }
    
    // 현재 카드를 섞는 함수
    mutating func shuffle() {
        guard count() > 1 else {
            return
        }
        
        for count in stride(from: count() - 1, to: 0, by: -1) {
            deck.swapAt(count, Int(arc4random_uniform(count.convertUInt32())))
        }
    }
    
    // 카드 하나를 리턴하는 함수
    mutating func removeOne() -> Card {
        return deck.removeLast()
    }
    
    // 카드를 초기 상태로 되돌리고 섞는 함수
    mutating func reset() {
        var resetCards: [Card] = []
        
        for suit in Suits.allValues {
            for shape in Shape.allValues {
                resetCards.append(Card( suit, shape))
            }
        }
        self.deck = resetCards
    }
}
