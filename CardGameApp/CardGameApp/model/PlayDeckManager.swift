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
    func addCard(card: Card) {
        // 모든 덱 대상
        for playDeck in playDeckList {
            // 추가가능여부 체크는 플레이덱에서 수행됨
            playDeck.addCard(card: card)
        }
    }
    
}
