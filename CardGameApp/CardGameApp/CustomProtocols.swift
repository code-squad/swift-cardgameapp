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
    func getStackDelegate(of column: Int) -> StackDelegate
    func getDeckDelegate() -> DeckDelegate
}

// MARK: RuleCheck Related

protocol Stackable {
    func isStackable(nextCard card: Card) -> [Bool]
    func stackUp(newCard: Card)
}
