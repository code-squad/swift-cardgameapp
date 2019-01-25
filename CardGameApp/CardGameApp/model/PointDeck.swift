//
//  PointDeck.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 1. 24..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

class PointDeck {
    /// 전용 마크가 필요함
    let mark : Mark
    /// 마크랭크
    let markRank : Int
    /// 카드배열
    private var cardList : [Card] = []
    
    
    // allCases 에 해당 값이 없으면 안되므로 ! 사용
    init(mark: Mark){
        self.mark = mark
        self.markRank = Mark.allCases().index(of: mark)!
    }
    
    /// 카드정보를 받아서 추가 가능한 객체인지 체크
    func checkAdd(card: Card) -> Bool {
        // 마크가 같은지 체크. 다를경우 거짓 리턴
        
        if card.getMarkRank() != self.markRank {
            return false
        }
        
        // 기존카드가 없을경우
        guard let lastCard = cardList.last else {
            // 숫자랭크가 1등이여야한다 = 0
            return card.getNumberingRank() == 0
        }
        
        // 기존 카드들이 있을경우 넘버링 값 비교. 바로 다음카드값이여야함
        if lastCard.markNumberingDefference(cardInfo: card) == 1 {
            return true
        }
        else {
            return false
        }
    }
    
    /// 카드를 추가한다
    func addCard(card: Card){
        cardList.append(card)
    }
}
