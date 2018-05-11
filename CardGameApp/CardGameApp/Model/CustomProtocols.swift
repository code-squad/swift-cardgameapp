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
    func getDeckDelegate() -> DeckDelegate
    func getWholeStackDelegate() -> WholeStackDelegate
    func getFoundationDelegate() -> FoundationManageable
    func shuffleDeck()
    func movableFromDeck(from: ViewKey) -> (to: ViewKey, index: Int?)
    func movableFromStack(from: ViewKey, column: Int) -> (to: ViewKey, index: Int?)
    func popOpenDeck()
    func popStack(column: Int)
}

// MARK: RuleCheck Related

protocol Stackable {
    func newStackable(nextCard card: Card) -> Int?
    func newStackUp(newCard: Card, column: Int)
}
