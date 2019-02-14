//
//  PlayDeckManager.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 2. 3..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

class PlayDeckManager {
    /// 플레이덱 배열화
    var playDeckList : [PlayDeck] = []
    
    /// 카드를 받아서 추가
    func addCard(card: Card) -> CardInfo? {
        // 모든 덱 대상
        for playDeck in playDeckList {
            // 추가성공시 추가된 카드 정보를 리턴
            if let addedCard = playDeck.addCard(card: card) {
                return addedCard
            }
        }
        // 추가 실패리 닐리턴
        return nil
    }
    
}
