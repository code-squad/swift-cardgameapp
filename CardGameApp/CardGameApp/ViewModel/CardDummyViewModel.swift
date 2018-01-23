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
        return cardStacks.map { _ in CardStack() }
    }

    func reset() {
        cardDummy.removeAll()
        cardDummy = makeCardDummy()
    }
}

extension CardDummyViewModel: MovableViewModel {
    func top(index: Int) -> Card? {
        return cardDummy[index].top
    }

    @discardableResult func pop(index: Int, count: Int) -> [Card] {
        var pops = [Card]()
        for _ in 0..<count {
            guard let pop = cardDummy[index].pop() else { break }
            pops.append(pop)
        }
        let top = cardDummy[index].top
        NotificationCenter.default.post(
            name: .didPopCardNotification,
            object: self,
            userInfo: ["card": top, "index": index]
        )
        return pops
    }

    func push(index: Int, cards: [Card]) {
        let newCards = cards.reversed()
        newCards.forEach { cardDummy[index].push(card: $0) }
        NotificationCenter.default.post(
            name: .didPushCardNotification,
            object: self,
            userInfo: ["card": cards, "index": index]
        )
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

}

extension Notification.Name {
    static let didPopCardNotification = Notification.Name(rawValue: "didPopCard")
    static let didPushCardNotification = Notification.Name(rawValue: "didPushCard")
}
