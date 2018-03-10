//
//  CardStackTest.swift
//  CardGameAppTests
//
//  Created by TaeHyeonLee on 2018. 3. 9..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import XCTest

@ testable import CardGameApp

class CardStackTest: XCTestCase {
    var cardStack: CardStack!
    let spadesAce: Card = Card.init(suit: .spades, rank: .ace)
    let spadesTwo: Card = Card.init(suit: .spades, rank: .two)
    let heartsThree: Card = Card.init(suit: .hearts, rank: .three)
    let heartsFour: Card = Card.init(suit: .hearts, rank: .four)
    let diamondsFive: Card = Card.init(suit: .diamonds, rank: .five)
    let diamondsSix: Card = Card.init(suit: .diamonds, rank: .six)
    let clubsSeven: Card = Card.init(suit: .clubs, rank: .seven)
    let clubsEight: Card = Card.init(suit: .clubs, rank: .eight)

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        cardStack = nil
        super.tearDown()
    }

    func testIsEmpty() {
        cardStack = CardStack(cardPack: [])
        XCTAssert(cardStack.isEmpty())
    }

    func testReset() {
        let cardPack = [spadesAce, heartsFour, diamondsFive, clubsEight]
        cardStack = CardStack(cardPack: cardPack)
        XCTAssert(!cardStack.isEmpty())
        cardStack.reset()
        XCTAssert(cardStack.isEmpty())
    }

    func testPush() {
        cardStack = CardStack(cardPack: [])
        XCTAssert(cardStack.isEmpty())
        cardStack.push(card: heartsFour)
        XCTAssert(!cardStack.isEmpty())
    }

    func testPop() {
        cardStack = CardStack(cardPack: [diamondsFive])
        XCTAssert(!cardStack.isEmpty())
        XCTAssertEqual(diamondsFive, cardStack.pop())
        XCTAssert(cardStack.isEmpty())
    }

    func testSelectedCard() {
        cardStack = CardStack(cardPack: [diamondsFive])
        XCTAssertEqual(diamondsFive, cardStack.selectedCard(image: diamondsFive.image))
    }

    func testIndex() {
        let cardPack = [spadesAce, heartsFour, diamondsFive, clubsEight]
        cardStack = CardStack(cardPack: cardPack)
        XCTAssertNil(cardStack.index(of: spadesAce))
        XCTAssertNil(cardStack.index(of: heartsFour))
        XCTAssertNil(cardStack.index(of: diamondsFive))
        XCTAssertEqual(cardPack.index(of: clubsEight), cardStack.index(of: clubsEight))
    }

    func testGetImagesAll() {
        cardStack = CardStack(cardPack: [])
        XCTAssertEqual(cardStack.getImagesAll(), [])
        let cardPack = [spadesAce, heartsFour, diamondsFive, clubsEight]
        cardStack = CardStack(cardPack: cardPack)
        XCTAssertEqual(cardStack.getImagesAll(),
                       [Figure.Image.back.value,
                        Figure.Image.back.value,
                        Figure.Image.back.value,
                        clubsEight.image])
    }

    func testIsAttachable() {
        let cardPack = [clubsSeven, heartsFour, diamondsFive, heartsThree]
        cardStack = CardStack(cardPack: cardPack)
        XCTAssertFalse(cardStack.isAttachable(card: spadesAce))
        XCTAssertFalse(cardStack.isAttachable(card: diamondsSix))
        XCTAssertTrue(cardStack.isAttachable(card: spadesTwo))
    }

    func testIsStackable() {
        let cardPack = [clubsSeven, spadesAce, diamondsFive, heartsThree]
        cardStack = CardStack(cardPack: cardPack)
        XCTAssertFalse(cardStack.isStackable(card: spadesTwo))
        XCTAssertFalse(cardStack.isStackable(card: diamondsSix))
        XCTAssertTrue(cardStack.isStackable(card: heartsFour))
    }

}
