//
//  CardDeck.swift
//  CardGame
//
//  Created by 윤동민 on 04/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class CardDeck {
    private var cardDeck : [Card] = []
    
    // cardDeck을 초기화
    init() {
        createNewDeck()
        shuffle()
    }
    
    // 카드 덱 초기화
    func reset() {
        deckClear()
        createNewDeck()
    }
    
    // 카드 덱을 초기화 하기 전 이전 덱 클리어
    private func deckClear() {
        cardDeck.removeAll()
    }
    
    // 새로운 카드 덱 생성
    private func createNewDeck() {
        for shape in CardShape.allCases {
            for number in CardNumber.allCases {
                cardDeck.append(Card(shape, number))
            }
        }
    }
    
    // 카드 덱의 현재 카드 개수를 반환
    func count() -> Int {
        return cardDeck.count
    }
    
    // 카드 덱을 섞음
    func shuffle() {
        var tempCardDeck : [Card] = []
        var tempCard : Card
        for step in stride(from: cardDeck.count-1, through: 0, by: -1) {
            tempCard = cardDeck.remove(at: Int(arc4random_uniform(UInt32(step))))
            tempCardDeck.append(tempCard)
        }
        cardDeck = tempCardDeck
    }
    
    // 카드 덱의 젤 위를 반환하고 카드 덱에서 삭제
    func removeOne() -> Card? {
        guard cardDeck.count != 0 else { return nil }
        return cardDeck.remove(at: cardDeck.count-1)
    }
    
    func isOverGame() -> Bool {
        guard cardDeck.count == 0 else { return false }
        return true
    }
}
