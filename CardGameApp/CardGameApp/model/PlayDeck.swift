//
//  PlayDeck.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 1. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

/// 펼쳐진 카드들의 모임
class PlayDeck {
    // 카드들
    private var cardList : [Card] = []
    
    /// 카드를 받아서 추가 가능한 카드인지 체크
    func checkAdd(card: Card) -> Bool {
        // 카드리스트에 가드가 존재하는지 체크
        guard let lastCard = cardList.last else {
            // 한장도 없을경우 K = 마지막넘버링 만 추가가능하다.
            return card.getNumberingRank() == Numbering.allCases().count - 1
        }
        // 카드리스트에 카드가 존재. 색이 다른지 체크
        if card.checkDifferentMarkColor(cardInfo: lastCard) == false {
            // 색이 다르고, 이전 넘버링인지 체크
            if lastCard.markNumberingDifference(cardInfo: card) == -1 {
                return true
            }
        }
        
        // 색이 같거나 이전 넘버링이 아니면 안됨
        return false
    }
    
    /// 카드를 받아서 추가함. 내부에서 체크함수 돌림
    func addCard(card: Card) -> CardInfo?{
        // 추가 가능한지 체크
        if checkAdd(card: card) {
            // 추가가능하면 덱타입 변경
            card.deckType = .playDeck
            
            // 추가후 카드정보 리턴
            cardList.append(card)
            // 카드정보 리턴
            return card
        }
        // 추가실패시 닐리턴
        return nil
    }
    
    /// 초기 세팅을 위한 카드추가
    func setting(card: Card){
        // 과거카드정보 생성
        let pastCardData = PastCardData(cardInfo: card)
        self.cardList.addCard(card)
        
        // 카드 이동 후 덱타입 변경
        card.deckType = .playDeck
        // 카드가 이동했으니 과거카드정보 노티 포스트
        NotificationCenter.default.post(name: .cardMoved, object: pastCardData)
    }
    
    /// 초기세팅을 위한 카드배열 추가
    func seting(cards: [Card], deckLine: Int){
        for card in cards {
            // 덱 라인을 변경
            card.deckLine = deckLine
            setting(card: card)
        }
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
    
    /// 모든 카드의 카드정보를 리턴한다
    func getAllCardInfo() -> [CardInfo] {
        return self.cardList
    }
    
    /// 카드 강제추가. 카드를 되돌리는 역할
    func undoCard(card: Card){
        self.cardList.append(card)
    }
    
    /// 카드를 모두 리턴하고 배열을 비운다
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
}
