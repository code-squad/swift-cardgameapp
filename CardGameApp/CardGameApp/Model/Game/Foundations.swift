//
//  Foundations.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class Foundations: Sequence {
    let start: Int = 0
    private let count: Int = 4
    private let stacks: [Foundation]

    init() {
        stacks = (0..<count).map { _ in Foundation() }
    }

    func makeIterator() -> ClassIteratorOf<Foundation> {
        return ClassIteratorOf(self.stacks)
    }

    func reset() {
        stacks.forEach { $0.reset() }
    }

    func searchSuitableLocation(for card: Card) -> Location? {
        for (index, foundation) in stacks.enumerated() where foundation.canPush(card) {
            return Location.foundation(index)
        }
        return nil
    }

    func pop(from index: Int) -> Card? {
        return stacks[index].pop()
    }

    func push(_ card: Card, to index: Int) {
        stacks[index].push(card: card)
    }

    func canPush(_ card: Card, to index: Int) -> Bool {
        return stacks[index].canPush(card)
    }
}
