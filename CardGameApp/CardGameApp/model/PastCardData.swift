//
//  pastCardData.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 2. 20..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

/// 카드 이동전의 데이터가 모이는 객체
class PastCardData {
    let deckType : DeckType
    let deckLine : Int
    
    init(cardInfo: CardInfo){
        self.deckType = cardInfo.getDeckType()
        self.deckLine = cardInfo.getDeckLine()
    }
}
