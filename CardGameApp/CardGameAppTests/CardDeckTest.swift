//
//  CardDeckTest.swift
//  CardGameAppTests
//
//  Created by yangpc on 2017. 12. 25..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import XCTest
@testable import CardGameApp

class CardDeckTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_cardDeck_count() {
        let cardDeck = CardDeck()
        XCTAssertEqual(cardDeck.count(), 52)
    }

    func test_cardDeck_shuffle() {
        var cardDeck = CardDeck()
        cardDeck.shuffle()
        let originalCards = CardDeck()
        for card in originalCards.cards {
            XCTAssertTrue(cardDeck.cards.contains {
                $0.description == card.description
            })
        }
    }

}
