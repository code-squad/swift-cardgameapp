//
//  CustomProtocols.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 3..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

// MARK: CardImage Related

protocol ImageSelector {
    var frontImage: String { get }
    var backImage: String { get }
    var image: String { get }
}

// MARK: CardGame Related

protocol CardGameManageable {
    func getDeckDelegate() -> CardDeckManageable
    func getWholeStackDelegate() -> (CardStackManageable & Stackable)
    func getFoundationDelegate() -> (FoundationManageable & Stackable)
    func shuffleDeck()
    func movableFromDeck(from: ViewKey) -> (to: ViewKey, index: Int?)
    func movableFromStack(from: ViewKey, column: Int) -> (to: ViewKey, index: Int?)
    func popOpenDeck()
    func popStack(column: Int)
}

protocol CardDeckManageable {
    func hasEnoughCard() -> Bool
    func lastOpenedCard() -> Card?
    func shuffleDeck()
    func removePoppedCard()
    func pop()
}

protocol CardStackManageable {
    func lastCard(of column: Int) -> Card
    func removePoppedCard(of column: Int)
    func getStackDelegate(of column: Int) -> StackManageable
}

protocol FoundationManageable {
    func cardInTurn(at:(column: Int, row: Int)) -> Card
    func countOfCards(of: Int) -> Int
    func cards(in column: Int) -> [Card]
}

protocol StackManageable {
    func countOfCard() -> Int
    func cardInTurn(at index: Int) -> Card
    func removePoppedCard()
    func currentLastCard() -> Card
    func isStackable(nextCard: Card) -> Bool
    func stackUp(newCard: Card)
}

// MARK: RuleCheck Related

protocol Stackable {
    func stackable(nextCard card: Card) -> Int?
    func stackUp(newCard: Card, column: Int)
}

