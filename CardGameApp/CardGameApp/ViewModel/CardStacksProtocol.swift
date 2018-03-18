//
//  CardStacks.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 9..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

typealias CardIndexes = (xIndex: Int, yIndex: Int)
typealias CardInformation = (card: Card, indexes: CardIndexes)
typealias CardImages = [String]

protocol CardStacksProtocol {
    func reset()
}

protocol Receivable {
    func availablePosition(of card: Card) -> CardIndexes?
    func availablePositionsForDragging(of card: Card) -> [CardIndexes]
    func push(cards: [Card], indexes: CardIndexes) -> Bool
}

protocol Sendable {
    func getSelectedCardInformation(image: String) -> CardInformation?
    func pop(indexes: CardIndexes) -> [Card]
}
