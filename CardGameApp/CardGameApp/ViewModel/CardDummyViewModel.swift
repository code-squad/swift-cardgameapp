//
//  CardDummyViewModel.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 14..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class CardDummyViewModel {
    private var cardDummy = [CardStack]()

    init() {
        cardDummy = makeCardDummy()
    }

    private func makeCardDummy() -> [CardStack] {
        let cardStacks = [CardStack?](repeating: nil, count: 4)
        return cardStacks.map { _ in return CardStack() }
    }

    // Top View로 이동 시, 카드가 이동할 Top View 인덱스를 반환
    func targetIndex(card: Card) -> Int? {
        for index in 0..<cardDummy.count {
            let top = cardDummy[index].top
            if card.isSameSuitAndNextRank(with: top) {
                return index
            }
        }
        return nil
    }

    func reset() {
        cardDummy.removeAll()
        cardDummy = makeCardDummy()
    }
}

extension CardDummyViewModel: CardStackMovableModel {
    func top(index: Int) -> Card? {
        return cardDummy[index].top
    }

    @discardableResult func pop(index: Int) -> Card? {
        return cardDummy[index].pop()
    }

    func push(index: Int, card: Card) {
        cardDummy[index].push(card: card)
    }
}
