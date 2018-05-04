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
    func makeStacks(numberOfCards: Int) -> [CardStack]
    func countOfDeck() -> Int
    func pickACard() -> Card
    func shuffleDeck()
    func currentDeck() -> CardDeck
    func hasEnoughCard() -> Bool
    func getStackDelegate(of column: Int) -> StackDelegate
    func currentOpen() -> Card?
    func hasOpenedCard() -> Bool
}

protocol FoundationManageable {
    func makeEmptyFoundation()
    func stackUp(newCard: Card)
    func updateFoundation()
}
