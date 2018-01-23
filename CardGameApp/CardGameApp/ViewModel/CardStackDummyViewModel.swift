//
//  CardStackDummyViewModel.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 11..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class CardStackDummyViewModel {
    private var cardDeck = CardDeck()
    private(set) var cardStacks = [CardStack]()
    var remainCards: [Card] {
        return cardDeck.cards
    }
    init() {
        cardStacks = makeCardStack()
    }

    // 카드 스택 배열 만들기
    private func makeCardStack() -> [CardStack] {
        cardDeck.shuffle()
        var newCardStacks = [CardStack]()
        for i in 1...7 {
            guard let cards = try? cardDeck.pickCards(number: i) else {
                continue
            }
            newCardStacks.append(CardStack(cards: cards))
        }
        return newCardStacks
    }

    func reset() {
        cardDeck.reset()
        cardStacks.removeAll()
        cardStacks = makeCardStack()
    }

    func count(cardStackIndex: Int) -> Int {
        return cardStacks[cardStackIndex].count
    }
}

extension CardStackDummyViewModel: MovableViewModel {
    func top(index: Int) -> Card? {
        return cardStacks[index].top
    }

    func lastShowCards(index: Int, count: Int) -> [Card]? {
        return cardStacks[index].lastCards(count: count)
    }

    @discardableResult func pop(index: Int, count: Int) -> [Card] {
        var pops = [Card]()
        for _ in 0..<count {
            guard let pop = cardStacks[index].pop() else { break }
            pops.append(pop)
        }
        let top = cardStacks[index].top
        NotificationCenter.default.post(
            name: .didPopCardNotification,
            object: self,
            userInfo: ["card": top, "index": index]
        )
        return pops
    }

    func push(index: Int, cards: [Card]) {
        let newCards = cards.reversed()
        newCards.forEach { cardStacks[index].push(card: $0) }
        NotificationCenter.default.post(
            name: .didPushCardNotification,
            object: self,
            userInfo: ["card": cards, "index": index]
        )
    }

    // card Stack View로 이동 시, 카드가 이동할 card stack view 인덱스를 반환
    func targetIndex(card: Card) -> Int? {
        for index in 0..<cardStacks.count {
            let top = cardStacks[index].top
            if card.isDifferentColorAndPreviousRank(with: top) {
                return index
            }
        }
        return nil
    }
}
