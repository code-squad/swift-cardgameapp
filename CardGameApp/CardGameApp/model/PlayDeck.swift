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
        if card.checkDifferentMarkColor(card: lastCard) {
            // 색이 같음, 이전 넘버링인지 체크
            if lastCard.markNumberingDifference(cardInfo: card) == -1 {
                return true
            }
        }
        
        // 색이 같거나 이전 넘버링이 아니면 안됨
        return false
    }
    
//    /// 다른색인지 구분하는 함수. 플레이카드는 다른색,넘버링+1 만 들어올수 있다
//    func checkDifferentMarkColor(cardOne: Card, cardTwo: Card) -> Bool {
//        // 스페이드,클로버는 짝수. 하트,다이아는 홀수다. 2로 나눈 값이 달라야 추가 가능하다
//        return cardOne.getMarkRank() % 2 != cardTwo.getMarkRank() % 2
//
//    }
    
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
    
    /// 카드인포를 받아서 마지막 카드와 맞는지 체크. 맞으면 카드인포 리턴
    func checkPickable(cardInfo: CardInfo) -> Card? {
        // 같은 카드가 맞다면
        if cardInfo.name() == self.cardList.last?.name() {
            return self.cardList.last
        } else {
            return nil
        }
    }
    
    /// 모든 카드의 카드정보를 리턴한다
    func getAllCardInfo() -> [CardInfo] {
        return self.cardList
    }
    
    /// 카드 강제추가. 카드를 되돌리는 역할
    func undoCard(card: Card){
        self.cardList.append(card)
    }
}
