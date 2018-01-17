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

    func pop(index: Int) -> Card? {
        let pop = cardDummy[index].pop()
        let top = cardDummy[index].top
        NotificationCenter.default.post(
            name: .didPopCardNotification,
            object: self,
            userInfo: ["card": top, "index": index]
        )
        return pop
    }
    func push(index: Int, card: Card) {
        cardDummy[index].push(card: card)
        NotificationCenter.default.post(
            name: .didPushCardNotification,
            object: self,
            userInfo: ["card": card, "index": index]
        )
    }

}

extension Notification.Name {
    static let didPopCardNotification = Notification.Name(rawValue: "didPopCard")
    static let didPushCardNotification = Notification.Name(rawValue: "didPushCard")
}
