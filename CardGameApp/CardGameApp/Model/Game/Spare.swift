//
//  Spare.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class Spare: CardStack {
    func push(_ cards: [Card]) {
        cards.forEach {
            push(card: $0)
        }
    }

    func reset(with cards: [Card]) {
        reset()
        push(cards)
    }
}
