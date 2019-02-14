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
        if checkDifferentMarkColor(cardOne: card, cardTwo: lastCard) {
            // 색이 같음, 이전 넘버링인지 체크
            if lastCard.markNumberingDifference(cardInfo: card) == -1 {
                return true
            }
        }
        
        // 색이 같거나 이전 넘버링이 아니면 안됨
        return false
    }
    
    /// 다른색인지 구분하는 함수. 플레이카드는 다른색,넘버링+1 만 들어올수 있다
    func checkDifferentMarkColor(cardOne: Card, cardTwo: Card) -> Bool {
        // 스페이드,클로버는 짝수. 하트,다이아는 홀수다. 2로 나눈 값이 달라야 추가 가능하다
        return cardOne.getMarkRank() % 2 != cardTwo.getMarkRank() % 2
        
    }
    
    /// 카드를 받아서 추가함. 내부에서 체크함수 돌림
    func addCard(card: Card) -> CardInfo?{
        // 추가 가능한지 체크
        if checkAdd(card: card) {
            // 추가성공하면 추가후 카드정로 리턴
            cardList.append(card)
            // 덱타입을 변경
            cardList.last!.deckType = .playDeck
            return card
        }
        // 추가실패시 닐리턴
        return nil
    }
    
}
