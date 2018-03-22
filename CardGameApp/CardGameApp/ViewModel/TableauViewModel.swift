//
//  TableauPilesViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class TableauViewModel {//: ContainsCardStack {
    private(set) var cardDummy: CardStack
    private(set) var cardViewModels: CollectionObservable<[CardViewModel]>
    private let faceState: FaceState = .down
    private let borderState: BorderState = .hide
    private(set) var location: Location
    var isAdded: Bool?

    init(stackNumber: Int) {
        self.cardDummy = CardStack()
        self.cardViewModels = CollectionObservable([])
        self.location = .tableau(stackNumber)
    }

    init(cardDummy: CardStack, stackNumber: Int) {
        self.cardDummy = cardDummy
        self.location = .tableau(stackNumber)
        self.cardViewModels = CollectionObservable([])
        updateCardViewModels()
    }

    // 통째로 붙인 경우 CardViewModel 초기화
    private func updateCardViewModels() {
        self.cardViewModels.collection = self.cardDummy.flatMap {
            $0.convertToCardViewModel(faceState, borderState: borderState, on: self.location)
        }
    }

    func turnOverLastCard(to faceState: FaceState) {
        // 마지막 장은 뒤집는다.
        self.cardViewModels.collection.last?.turnOver(toFace: faceState)
    }

    func setCardDummy(_ cardDummy: CardStack) {
        self.cardDummy = cardDummy
        updateCardViewModels()
    }

    func canPush(_ card: Card) -> Bool {
        // 프론트 카드가 없으면 비어있다는 의미
        guard let frontCard = cardDummy.peek() else {
            return card.number == .king
        }
        // 프론트 카드가 있는 경우
        return (card.number.rawValue == frontCard.number.rawValue-1) && (card.color != frontCard.color)
    }

    // 기존 CardViewModel 변경 없이 카드 붙임
    func push(_ card: Card?) {
        guard let card = card else { return }
        if canPush(card) {
            cardDummy.push(card: card)
        }
        addCardViewModel(card: card)
    }

    private func addCardViewModel(card: Card) {
        // 현재 추가된 카드는 맨 마지막 장이므로, up 상태로 붙임.
        let cardViewModel = card.convertToCardViewModel(.up, borderState: borderState, on: self.location)
        self.isAdded = true
        self.cardViewModels.collection.append(cardViewModel)
    }

    func pop() -> Card? {
        cardViewModels.collection.removeLast()
        self.isAdded = false
        return cardDummy.pop()
    }

    func isEmpty() -> Bool {
        return self.cardDummy.count <= 0
    }

    var frontCard: Card? {
        return cardDummy.peek()
    }

    func reset() {
        cardDummy.reset()
        cardViewModels.collection = []
        self.isAdded = nil
    }
}
