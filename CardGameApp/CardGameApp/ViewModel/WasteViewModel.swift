//
//  WasteViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class WasteViewModel {//: ContainsCardStack {
    private(set) var cardDummy: CardStack
    private(set) var cardViewModels: CollectionObservable<[CardViewModel]>
    private let faceState: FaceState = .up
    private let borderState: BorderState = .hide

    init() {
        self.cardDummy = CardStack()
        self.cardViewModels = CollectionObservable([])
    }

    init(cardDummy: CardStack) {
        self.cardDummy = cardDummy
        self.cardViewModels = CollectionObservable([])
        updateCardViewModels()
    }

    private func updateCardViewModels() {
        self.cardViewModels.collection = self.cardDummy.flatMap {
            $0.convertToCardViewModel(faceState, borderState: borderState, on: .waste)
        }
    }

    func isEmpty() -> Bool {
        return self.cardDummy.count <= 0
    }

    func reversed() -> CardStack {
        return CardStack(self.cardDummy.reversed())
    }

    func setCardDummy(_ cardDummy: CardStack) {
        self.cardDummy = cardDummy
        updateCardViewModels()
    }

    func push(_ card: Card?) {
        guard let card = card else { return }
        cardDummy.push(card: card)
        updateCardViewModels()
    }

    func pop() -> Card? {
        _ = cardViewModels.collection.popLast()
        return cardDummy.pop()
    }

    var frontCard: Card? {
        return cardDummy.peek()
    }

    func reset() {
        cardDummy.reset()
        cardViewModels.collection = []
    }
}
