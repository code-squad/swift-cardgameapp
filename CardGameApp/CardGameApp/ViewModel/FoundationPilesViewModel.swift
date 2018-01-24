//
//  FoundationPilesViewModel.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 14..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class FoundationPilesViewModel {
    private var foundationPiles = [CardStack]()

    init() {
        foundationPiles = makefoundationPiles()
    }

    private func makefoundationPiles() -> [CardStack] {
        let cardStacks = [CardStack?](repeating: nil, count: 4)
        return cardStacks.map { _ in CardStack() }
    }

    func reset() {
        foundationPiles.removeAll()
        foundationPiles = makefoundationPiles()
    }

    func isFullDeck() -> Bool {
        var total = 0
        foundationPiles.forEach { total += $0.count }
        return total == 53
    }
}

extension FoundationPilesViewModel: MovableViewModel {
    func faceUpCards(index: Int, count: Int) -> [Card]? {
        return foundationPiles[index].lastCards(count: 1)
    }

    func top(index: Int) -> Card? {
        return foundationPiles[index].top
    }

    @discardableResult func pop(index: Int, count: Int) -> [Card] {
        var pops = [Card]()
        for _ in 0..<count {
            guard let pop = foundationPiles[index].pop() else { break }
            pops.append(pop)
        }
        let top = foundationPiles[index].top
        NotificationCenter.default.post(
            name: .didPopCardNotification,
            object: self,
            userInfo: ["card": top, "index": index]
        )
        return pops
    }

    func push(index: Int, cards: [Card]) {
        let newCards = cards.reversed()
        newCards.forEach { foundationPiles[index].push(card: $0) }
        NotificationCenter.default.post(
            name: .didPushCardNotification,
            object: self,
            userInfo: ["card": cards, "index": index]
        )
    }

    // Top View로 이동 시, 카드가 이동할 Top View 인덱스를 반환
    func targetIndex(card: Card) -> Int? {
        for index in 0..<foundationPiles.count {
            let top = foundationPiles[index].top
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
