//
//  CardStackViewModel.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 11..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class CardStackViewModel {
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

    // 카드 스택 뷰 배열 만들기
    func makeCardStackView(frame: CGRect, action: Action) -> [CardStackView] {
        var cardStackViews = [CardStackView]()
        cardStacks.forEach {
            let lastIndex = $0.count - 1
            let cardStackView = CardStackView(frame: frame)
            cardStackView.setCardStackImageView($0)
            cardStackView.addDoubleTapGestureAllSubViews(action: action)
            cardStackView.validUserInterationOnly(on: lastIndex)
            cardStackViews.append(cardStackView)
        }
        return cardStackViews
    }

    // card Stack View로 이동 시, 카드가 이동할 card stack view 인덱스를 반환
    func selectTargetCardStackViewIndex(card: Card) -> Int? {
        for index in 0..<cardStacks.count {
            let top = cardStacks[index].top
            if card.isDifferentColorAndPreviousRank(with: top) {
                return index
            }
        }
        return nil
    }

    func count(cardStackIndex: Int) -> Int {
        return cardStacks[cardStackIndex].count
    }

    func top(cardStackIndex: Int) -> Card? {
        return cardStacks[cardStackIndex].top
    }

    @discardableResult func pop(cardStackIndex: Int) -> Card? {
        return cardStacks[cardStackIndex].pop()
    }

    func push(cardStackIndex: Int, card: Card) {
        cardStacks[cardStackIndex].push(card: card)
    }
}
