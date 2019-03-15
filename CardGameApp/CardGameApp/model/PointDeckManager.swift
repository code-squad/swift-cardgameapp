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
    
    /// 카드를 받아서 맞는 포인트덱에 카드 추가
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
        // 결과출력용 배열
        var result : [String] = []
        for card in  self.pointDeckList {
            // 모든카드 이름 추가
            result.append(card.lastCardName())
        }
        // 리턴
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
    
    /// 카드인포를 받아서 마지막 카드인지 체크
    func checklastCard(cardInfo: CardInfo) -> Bool {
        return self.pointDeckList[cardInfo.getDeckLine()].checklastCard(cardInfo: cardInfo)
    }
    
    /// 추가목표와 카드를 받아서 맞는 포인트덱에 카드 추가
    func addCard(targetCardInfo: CardInfo, card: Card) -> CardInfo? {
        // 목표에 추가
        return self.pointDeckList[targetCardInfo.getDeckLine()].addCard(card: card)
    }
    
    /// 카드인포를 받아서 해당 라인의 마지막 카드가 인포와 맞는지 체크. 맞으면 카드 리턴
    func pickCard(cardInfo: CardInfo) -> Card? {
        return self.pointDeckList[cardInfo.getDeckLine()].pickCard(cardInfo:cardInfo)
    }
    
    /// 카드와 덱라인을 받아서 해당 라인에 추가
    func addCardTo(deckLine: Int, card: Card) -> CardInfo? {
        // 추가 결과
        let result = self.pointDeckList[deckLine].addCard(card: card)
        
        // 덱 라인 설정
        if result != nil {
            card.deckLine = deckLine
        }
        
        return result
    }
    
    /// 덱 전체 리스트를 문자열로 리턴
    func getAllPointDeckCardName() -> [String] {
        // 결과용
        var result : [String] = []
        for count in 0..<self.pointDeckList.count {
            result.append("포인트덱 \(count)번라인 카드 : \(self.pointDeckList[count].getAllPointDeckCardName()) .")
        }
        return result
    }
}
