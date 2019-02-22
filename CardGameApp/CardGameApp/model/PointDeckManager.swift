//
//  PointDeckManager.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 1. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

/// 포인트덱을 관리하는 객체
class PointDeckManager {
    //// 포인트덱 4개 소지
    private var pointDeckList : [PointDeck]
    
    /// 생성자
    init(){
        pointDeckList = []
        
        // 모든 마크 생성
        let allMarks = Mark.allCases()
        
        // 마크개수로 추가
        for _ in allMarks {
            pointDeckList.append(PointDeck())
        }
    }
    
    /// 카드객체와 마크를 받아서 맞는 포인트덱에 카드 추가
    func addCard(card: Card) -> CardInfo? {
        // 모든 포인트덱이 대상
        for count in 0..<pointDeckList.count {
            // 추가성공시 추가된 카드 정보를 리턴
            if let addedCard = self.pointDeckList[count].addCard(card: card) {
                // 추가된 카드의 덱라인 변경
                card.deckLine = count
                return addedCard
            }
        }
        // 추가 실패시 닐리턴
        return nil
    }
    
    /// 카드인포를 받아서 추가가능한지 체크
    func checkAddable(cardInfo: CardInfo) -> Bool {
        // 모든 포인트덱이 대상
        for pointDeck in pointDeckList {
            // 추가성공시 추가된 카드 정보를 리턴
            if pointDeck.checkAdd(cardInfo: cardInfo) {
                return true
            }
        }
        // 추가 실패시 닐리턴
        return false
    }
    
    /// 체크용 전카드이름 리턴
    func allLastCardName() -> [String] {
        var result : [String] = []
        for card in  self.pointDeckList {
            result.append(card.lastCardName())
        }
        return result
    }
    
    /// 모든 카드를 리턴하고 난 후 비운다
    func reset() -> [Card] {
        var allCard : [Card] = []
        for cards in self.pointDeckList {
            allCard.append(contentsOf: cards.reset())
        }
        return allCard
    }
}
