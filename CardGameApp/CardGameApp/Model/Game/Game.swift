//
//  Game.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class Game {
    private var deck: Deck {
        didSet {
            spare.reset(with: deck.remnants()!)
        }
    }
    private(set) var foundations: [Foundation]
    private(set) var waste: CardStack
    private(set) var spare: Spare
    private(set) var tableaus: [Tableau]
    private let tableauConfig: [Int] = [1, 2, 3, 4, 5, 6, 7]

    init() {
        deck = Deck()
        foundations = (0..<4).map { _ in Foundation() }
        waste = CardStack()
        spare = Spare()
        tableaus = (0..<7).map { _ in Tableau() }
    }

    func new() {
        deck.reset()
        deck.shuffle()
        foundations.forEach { $0.reset() }
        waste.reset()
        (1...7).forEach {
            guard let fetchedCards = deck.fetch($0) else { return }
            tableaus[$0-1].reset(with: fetchedCards)
        }
        spare.reset(with: deck.remnants()!)
    }

    // waste -> spare
    func refreshWaste() {
        spare.push(waste.cards.collection)
    }

    func suitableLocation(_ card: Card) -> Location? {
        for (index, foundation) in foundations.enumerated() where foundation.canPush(card) {
            return Location.foundation(index)
        }
        for (index, tableau) in tableaus.enumerated() where tableau.canPush(below: card) {
            return Location.tableau(index)
        }
        return nil
    }

    /**
     * spare -> waste
     * waste -> tableau, foundation
     * foundation -> tableau
     * tableau -> tableau, foundation
     **/
    func move(cardsFrom card: Card, from fromLocation: Location, to toLocation: Location) {
        var movingCards: [Card] = []

        switch fromLocation {
        case .spare:
            guard let lastCard = spare.pop() else { break }
            movingCards.append(lastCard)
        case .waste:
            guard let lastCard = waste.pop() else { break }
            movingCards.append(lastCard)
        case .foundation(let index):
            guard let lastCard = foundations[index].pop() else { break }
            movingCards.append(lastCard)
        case .tableau(let index):
            movingCards = tableaus[index].popCards(below: card)
        }

        switch toLocation {
        case .spare: break
        case .waste: waste.push(card: card)
        case .foundation(let index) where foundations[index].canPush(card):
            foundations[index].push(card: card)
        case .tableau(let index) where tableaus[index].canPush(below: card):
            tableaus[index].push(cards: movingCards.flatMap { $0 })
        default: break
        }
    }
}
