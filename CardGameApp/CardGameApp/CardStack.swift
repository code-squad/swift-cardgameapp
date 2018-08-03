//
//  CardStack.swift
//  CardGameApp
//
//  Created by 김수현 on 2018. 7. 23..
//  Copyright © 2018년 김수현. All rights reserved.
//

import Foundation

class CardStack {
    
    func makeCardStack(_ deck: CardDeck) -> [[Card]] {
        var cardStack = [[Card]]()
        let range = 7
        for i in 0..<range {
            var tempCard = [Card]()
            for _ in 0...i {
                tempCard.append(deck.removeOne())
            }
            cardStack.append(tempCard)
        }
        return cardStack
    }

}
