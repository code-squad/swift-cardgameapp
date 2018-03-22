//
//  Tableaus.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class Tableaus: Sequence {
    let start: Int = 0
    private let count: Int = 7
    private let stacks: [Tableau]

    init() {
        stacks = (0..<count).map { _ in Tableau() }
    }

    func makeIterator() -> ClassIteratorOf<Tableau> {
        return ClassIteratorOf(self.stacks)
    }

    func reset(from deck: Deck) {
        (1...7).forEach {
            guard let fetchedCards = deck.fetch($0) else { return }
            stacks[$0-1].reset(with: fetchedCards)
        }
    }

    func searchSuitableLocation(for card: Card) -> Location? {
        for (index, tableau) in stacks.enumerated() where tableau.canPush(below: card) {
            return Location.tableau(index)
        }
        return nil
    }

    func pop(from index: Int, below card: Card) -> [Card] {
        return stacks[index].popCards(below: card)
    }

    func push(_ cards: [Card], to index: Int) {
        stacks[index].push(cards: cards)
    }

    func canPush(_ card: Card, to index: Int) -> Bool {
        return stacks[index].canPush(below: card)
    }
}
