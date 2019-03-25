//
//  OpendedDeck.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 2. 15..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

/// 덱에서 오픈된 카드들이 모이는곳
class OpenedDeck {
    var cardList : [Card] = []
    
    /// 오픈덱 리셋
    func reset() -> [Card]{
        let allCard = self.cardList
        self.cardList = []
        return allCard
    }
    
    /// 카드추가
    func addCard(card: Card){
        self.cardList.append(card)
    }
    
    /// 카드 전체 리턴
    func pickAllCard() -> [Card] {
        // 카드 전체를 미리 담아놓는다
        let allCard = self.cardList
        // 기존 리스트는 초기화
        self.cardList = []
        // 전체값 리턴
        return allCard
    }
    
    /// 카드 카운트
    func count() -> Int {
        return self.cardList.count
    }
    
    /// 카드인포를 받아서 맞는 카드가 있으면 리턴
    func pickCard(cardInfo: CardInfo) -> Card? {
        // 마지막 카드 추출
        guard let lastCardInfo = self.cardList.last else { return nil }
        
        // 받은 카드가 마지막 카드와 모양이 같은지 체크
        if lastCardInfo.isSame(cardInfo: cardInfo) {
            // 맞으면 카드 추출 후 리턴
            return self.cardList.popLast()
        }  // 다르면 닐 리턴
        else {
            return nil
        }
    }
    
    /// 카드 강제추가. 카드를 되돌리는 역할
    func undoCard(card: Card){
        // 조건없이 추가한다
        self.cardList.append(card)
    }
    
    /// 덱 전체 리스트를 문자열로 리턴
    func getAllOpenedDeckCardName() -> String {
        // 결과용 변수
        var result : String = "덱 카드 리스트 : "
        // 모든 카드를 문자열로 정리
        for card in cardList {
            result.append("\(card.name())\n")
        }
        // 리턴
        return result
    }
}
