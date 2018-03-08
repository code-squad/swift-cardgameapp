//
//  CardDeckTest.swift
//  CardGameTests
//
//  Created by TaeHyeonLee on 2017. 11. 27..
//  Copyright © 2017 ChocOZerO. All rights reserved.
//

import XCTest

@ testable import CardGameApp

class CardDeckTest: XCTestCase {
    var cardDeck: CardDeck!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        cardDeck = nil
        super.tearDown()
    }

    func testCount() {
        cardDeck = CardDeck()
        XCTAssertEqual(cardDeck.count(), 52)
    }

    func testRemoveOne() {
        cardDeck = CardDeck()
        let deletedCard: String = cardDeck.removeOne()!.description
        XCTAssertEqual(deletedCard, "♣️K")
        XCTAssertEqual(cardDeck.count(), 51)
        XCTAssertNotEqual(cardDeck[cardDeck.count()-1].description, "♣️K")
    }

    func testShuffle() {
        cardDeck = CardDeck()
        let cardDeck1: CardDeck = cardDeck
        cardDeck.shuffle()
        let cardDeck2: CardDeck = cardDeck
        XCTAssertNotEqual(cardDeck1[cardDeck1.count()-1].description, cardDeck2[cardDeck2.count()-1].description)
    }

    func testReset() {
        cardDeck = CardDeck()
        let cardDeck1: CardDeck = cardDeck
        let deletedCard: Card = cardDeck.removeOne()!
        XCTAssertEqual(cardDeck.count(), 51)
        XCTAssertEqual(deletedCard.description, "♣️K")
        cardDeck.shuffle()
        cardDeck.reset()
        let cardDeck2: CardDeck = cardDeck
        XCTAssertEqual(cardDeck1[cardDeck1.count()-1].description, cardDeck2[cardDeck2.count()-1].description)
    }

    func testGetCardPacks() {
        cardDeck = CardDeck()
        var cardDeck1: CardDeck = cardDeck
        XCTAssertEqual(cardDeck1.getCardPacks(packCount: 1)[0][0].description, "♣️K")
        var cardDeck2: CardDeck = cardDeck
        XCTAssertEqual(cardDeck2.getCardPacks(packCount: 3)[1][0].description, "♦️K")
    }

    func testLoad() {
        let diamondsAce: Card = Card.init(suit: .diamonds, rank: .ace)
        let heartsAce: Card = Card.init(suit: .hearts, rank: .ace)
        let spadesAce: Card = Card.init(suit: .spades, rank: .ace)
        let clubsAce: Card = Card.init(suit: .clubs, rank: .ace)
        var cardPack: CardPack = []
        cardPack.append(diamondsAce)
        cardPack.append(heartsAce)
        cardPack.append(spadesAce)
        cardPack.append(clubsAce)

        cardDeck = CardDeck()
        for _ in 0..<cardDeck.count() {
            _ = cardDeck.removeOne()
        }
        XCTAssertEqual(cardDeck.count(), 0)
        cardDeck.load(cardPack: cardPack)
        XCTAssertEqual(cardDeck.count(), 4)
        XCTAssertEqual(cardDeck[0].description, "♣️A")
    }

}
