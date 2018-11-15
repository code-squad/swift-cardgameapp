//
//  FoundationModel.swift
//  CardGameApp
//
//  Created by oingbong on 14/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class FoundationModel {
    private var cards = [Card]()
    
    func push(_ card: Card) {
        cards.append(card)
    }
    
    func pop() -> Card? {
        return cards.popLast()
    }
    
    func list() -> [Card] {
        return cards
    }
    
    func removeAll() {
        return cards = [Card]()
    }
}
