//
//  File.swift
//  CardGame
//
//  Created by 윤지영 on 16/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class CardStacks: CustomStringConvertible {
    private var cardStacks: [CardStack] = []

    init(from cardDeck: CardDeck, by num: Int = 7) {
        guard num > 0 else { return }
        let cardDeck = cardDeck
        for number in 1...num {
            guard let cardStack = cardDeck.removeMultiple(by: number) else { break }
            cardStack.flipLast()
            self.cardStacks.append(cardStack)
        }
    }

    var imageNames: [[String?]] {
        return cardStacks.map { $0.imageNames }
    }

    var description: String {
        let allCardStacks = cardStacks
            .map { "\($0)" }
            .joined(separator: "\n")
        return allCardStacks
    }

}
