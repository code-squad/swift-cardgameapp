//
//  EmptyCardViewModel.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 3. 15..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

class EmptyCardViewModel {
    var deckType = DeckType.deck
    var deckLine = 0
    
    // 설정
    func setting(deckType: DeckType, deckLine: Int){
        self.deckType = deckType
        self.deckLine = deckLine
    }
}
