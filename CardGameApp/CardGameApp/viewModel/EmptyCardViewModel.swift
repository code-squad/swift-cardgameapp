//
//  EmptyCardViewModel.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 3. 15..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

class EmptyCardViewModel {
    let deckType : DeckType
    let deckLine : Int
    
    init(deckType: DeckType, DeckLine: Int){
        self.deckLine = deckLine
        self.deckType = deckType
    }
}
