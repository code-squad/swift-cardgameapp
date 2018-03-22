//
//  GameViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class GameViewModel {
    private var deck: Deck {
        didSet {
            putCardsOnSpare()
        }
    }
    private(set) var spare: SpareViewModel
    private(set) var waste: WasteViewModel
    private(set) var foundation: [FoundationViewModel]
    private(set) var tableau: [TableauViewModel]

    init() {
        self.deck = Deck()
        self.spare = SpareViewModel()
        self.waste = WasteViewModel()
        self.foundation = (0..<Settings.foundationCount).map { FoundationViewModel(spaceNumber: $0) }
        self.tableau = (0..<Settings.maxStud).map { TableauViewModel(stackNumber: $0) }
        self.initialize()
    }

    func initialize() {
        deck.reset()
        spare.reset()
        waste.reset()
        foundation.forEach { $0.reset() }
        tableau.forEach { $0.reset() }
        deck.shuffle()
        putCardsOnTableau()
        putCardsOnSpare()
    }

    private func putCardsOnTableau() {
        for (count, tableau) in tableau.enumerated() {
            guard let fetchedCards = deck.fetch(count+1) else { break }
            tableau.setCardDummy(fetchedCards)
        }
    }

    private func putCardsOnSpare() {
        guard let remnants = deck.remnants() else { return }
        spare.setCardDummy(remnants)
    }

    // spare 카드뷰 탭 시 호출됨.
    func updateSpare() {
        if let card = spare.pop() {
            waste.push(card)
        } else {
            restore()
        }
    }

    private func restore() {
        spare.setCardDummy(waste.reversed())
        waste.reset()
    }

    func canMoveToLocation(_ card: Card) -> Location? {
        var endLocation: Location?
        for (index, space) in foundation.enumerated() where space.canPush(card) {
            endLocation = Location.foundation(index)
            break
        }
        for (index, stack) in tableau.enumerated() where stack.canPush(card) {
            endLocation = Location.tableau(index)
            break
        }
        return endLocation
    }

    typealias AfterMove = () -> Void

    func moveFrontCard(from fromLocation: Location, to toLocation: Location, completeHandler: @escaping AfterMove) {
        var movingCard: Card?
        switch fromLocation {
        case .spare: break
        case .waste: movingCard = waste.pop()
        case .foundation(let spaceNumber):
            if case let SpaceState.exist(card) = foundation[spaceNumber].spaceState {
                movingCard = card.value
            }
        case .tableau(let stackNumber):
            movingCard = tableau[stackNumber].pop()
        }

        switch toLocation {
        case .spare: break
        case .waste: waste.push(movingCard)
        case .foundation(let spaceNumber): foundation[spaceNumber].push(movingCard)
        case .tableau(let stackNumber):
            tableau[stackNumber].push(movingCard)
        }
    }

    struct Settings {
        static var maxStud: Int = 7
        static var foundationCount: Int = 4
        static var refresh: String = "cardgameapp-refresh-app"
    }
}
