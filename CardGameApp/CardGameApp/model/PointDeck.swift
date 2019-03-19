//
//  PointDeck.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 1. 24..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

class PointDeck {
    /// 카드배열
    private var cardList : [Card] = []
    
    /// 카드정보를 받아서 추가 가능한 객체인지 체크
    func checkAdd(cardInfo: CardInfo) -> Bool {
        
        // 기존카드가 없는지 체크
        guard let lastCard = cardList.last else {
            // 없다면 숫자랭크가 1등이여야한다 == 0
            return cardInfo.getNumberingRank() == 0
        }
        
        // 마크색이 같은지 체크. 다를경우 거짓 리턴
        if lastCard.checkDifferentMarkColor(cardInfo: cardInfo) == false {
            return false
        }
        
        // 기존 카드들이 있을경우 넘버링 값 비교. 바로 다음카드값이여야함
        if lastCard.markNumberingDifference(cardInfo: cardInfo) == 1 {
            return true
        }
        else {
            return false
        }
    }
    
    /// 카드를 추가한다
    func addCard(card: Card) -> CardInfo?{
        // 카드가 추가 가능한지 검사
        if checkAdd(cardInfo: card) {
            // 추가 가능하면 덱타입을 변경
            card.deckType = .pointDeck
            //후 추가, 카드정보 객체 리턴
            cardList.append(card)
            // 카드정보 리턴
            return card
        }
        // 추가 불가능시 닐리턴
        return nil
    }
    
    /// 체크용 전카드 이름 리턴
    func lastCardName() -> String {
        if let card = self.cardList.last {
            return card.name()
        }
        return "none"
    }
    
    /// 모든카드를 리턴하고 배열은 비운다
    func reset() -> [Card] {
        let allCard = self.cardList
        self.cardList = []
        return allCard
    }
    
    /// 카드인포를 받아서 마지막 카드가 맞는지 체크
    func checklastCard(cardInfo: CardInfo) -> Bool {
        // 마지막 카드가 있는지 체크
        guard let lastCard = self.cardList.last else {
            return false
        }
        // 있으면 비교
        return lastCard.checkSameName(name: cardInfo.name())
    }
    
    /// 카드인포를 받아서 마지막 카드와 맞는지 체크. 맞으면 카드리턴
    func pickCard(cardInfo: CardInfo) -> Card? {
        // 같은 카드가 맞다면
        if cardInfo.name() == self.cardList.last?.name() {
            // 카드 리턴
            return self.cardList.popLast()
        }
        // 다른카드면 닐 리턴
        return nil
    }
    
    /// 덱 전체 리스트를 문자열로 리턴
    func getAllPointDeckCardName() -> String {
        // 결과용
        var result : String = ""
        for card in cardList {
            result.append("\(card.name()), ")
        }
        return result
    }
    
    /// 카드 강제추가. 카드를 되돌리는 역할
    func undoCard(card: Card){
        self.cardList.append(card)
    }
    
    /// 맥스카운트를 받아서 현재 카운트와 같은지 리턴
    func checkSameCount(maxCount: Int) -> Bool {
        return maxCount == self.cardList.count
    }
}
