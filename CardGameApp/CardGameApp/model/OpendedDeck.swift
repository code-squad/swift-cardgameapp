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
    
    
    /// 리셋
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
        if cardInfo.name() == self.cardList.last?.name() {
            return self.cardList.popLast()
        }
        else {
            return nil
        }
    }
    
    /// 카드 강제추가. 카드를 되돌리는 역할
    func undoCard(card: Card){
        self.cardList.append(card)
    }
    
    /// 덱 전체 리스트를 문자열로 리턴
    func getAllOpenedDeckCardName() -> String {
        // 결과용
        var result : String = "덱 카드 리스트 : "
        for card in cardList {
            result.append("\(card.name())\n")
        }
        return result
    }
}
