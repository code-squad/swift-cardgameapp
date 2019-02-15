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
    func reset(){
        self.cardList = []
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
}
