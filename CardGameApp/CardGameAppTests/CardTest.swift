//
//  CardGameTests.swift
//  CardGameTests
//
//  Created by TaeHyeonLee on 2017. 11. 24..
//  Copyright © 2017 ChocOZerO. All rights reserved.
//

import XCTest

@testable import CardGameApp

class CardTests: XCTestCase {
    // spades
    let spadesAce: Card = Card.init(suit: .spades, rank: .ace)
    let spadesTwo: Card = Card.init(suit: .spades, rank: .two)
    let spadesThree: Card = Card.init(suit: .spades, rank: .three)
    let spadesFour: Card = Card.init(suit: .spades, rank: .four)
    let spadesFive: Card = Card.init(suit: .spades, rank: .five)
    let spadesSix: Card = Card.init(suit: .spades, rank: .six)
    let spadesSeven: Card = Card.init(suit: .spades, rank: .seven)
    let spadesEight: Card = Card.init(suit: .spades, rank: .eight)
    let spadesNine: Card = Card.init(suit: .spades, rank: .nine)
    let spadesTen: Card = Card.init(suit: .spades, rank: .ten)
    let spadesJack: Card = Card.init(suit: .spades, rank: .jack)
    let spadesQueen: Card = Card.init(suit: .spades, rank: .queen)
    let spadesKing: Card = Card.init(suit: .spades, rank: .king)
    // hearts
    let heartsAce: Card = Card.init(suit: .hearts, rank: .ace)
    let heartsTwo: Card = Card.init(suit: .hearts, rank: .two)
    let heartsThree: Card = Card.init(suit: .hearts, rank: .three)
    let heartsFour: Card = Card.init(suit: .hearts, rank: .four)
    let heartsFive: Card = Card.init(suit: .hearts, rank: .five)
    let heartsSix: Card = Card.init(suit: .hearts, rank: .six)
    let heartsSeven: Card = Card.init(suit: .hearts, rank: .seven)
    let heartsEight: Card = Card.init(suit: .hearts, rank: .eight)
    let heartsNine: Card = Card.init(suit: .hearts, rank: .nine)
    let heartsTen: Card = Card.init(suit: .hearts, rank: .ten)
    let heartsJack: Card = Card.init(suit: .hearts, rank: .jack)
    let heartsQueen: Card = Card.init(suit: .hearts, rank: .queen)
    let heartsKing: Card = Card.init(suit: .hearts, rank: .king)
    // diamonds
    let diamondsAce: Card = Card.init(suit: .diamonds, rank: .ace)
    let diamondsTwo: Card = Card.init(suit: .diamonds, rank: .two)
    let diamondsThree: Card = Card.init(suit: .diamonds, rank: .three)
    let diamondsFour: Card = Card.init(suit: .diamonds, rank: .four)
    let diamondsFive: Card = Card.init(suit: .diamonds, rank: .five)
    let diamondsSix: Card = Card.init(suit: .diamonds, rank: .six)
    let diamondsSeven: Card = Card.init(suit: .diamonds, rank: .seven)
    let diamondsEight: Card = Card.init(suit: .diamonds, rank: .eight)
    let diamondsNine: Card = Card.init(suit: .diamonds, rank: .nine)
    let diamondsTen: Card = Card.init(suit: .diamonds, rank: .ten)
    let diamondsJack: Card = Card.init(suit: .diamonds, rank: .jack)
    let diamondsQueen: Card = Card.init(suit: .diamonds, rank: .queen)
    let diamondsKing: Card = Card.init(suit: .diamonds, rank: .king)
    // clubs
    let clubsAce: Card = Card.init(suit: .clubs, rank: .ace)
    let clubsTwo: Card = Card.init(suit: .clubs, rank: .two)
    let clubsThree: Card = Card.init(suit: .clubs, rank: .three)
    let clubsFour: Card = Card.init(suit: .clubs, rank: .four)
    let clubsFive: Card = Card.init(suit: .clubs, rank: .five)
    let clubsSix: Card = Card.init(suit: .clubs, rank: .six)
    let clubsSeven: Card = Card.init(suit: .clubs, rank: .seven)
    let clubsEight: Card = Card.init(suit: .clubs, rank: .eight)
    let clubsNine: Card = Card.init(suit: .clubs, rank: .nine)
    let clubsTen: Card = Card.init(suit: .clubs, rank: .ten)
    let clubsJack: Card = Card.init(suit: .clubs, rank: .jack)
    let clubsQueen: Card = Card.init(suit: .clubs, rank: .queen)
    let clubsKing: Card = Card.init(suit: .clubs, rank: .king)

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDescriptionForSpades() {
        XCTAssertEqual(spadesAce.description, "♠️A")
        XCTAssertEqual(spadesTwo.description, "♠️2")
        XCTAssertEqual(spadesThree.description, "♠️3")
        XCTAssertEqual(spadesFour.description, "♠️4")
        XCTAssertEqual(spadesFive.description, "♠️5")
        XCTAssertEqual(spadesSix.description, "♠️6")
        XCTAssertEqual(spadesSeven.description, "♠️7")
        XCTAssertEqual(spadesEight.description, "♠️8")
        XCTAssertEqual(spadesNine.description, "♠️9")
        XCTAssertEqual(spadesTen.description, "♠️10")
        XCTAssertEqual(spadesJack.description, "♠️J")
        XCTAssertEqual(spadesQueen.description, "♠️Q")
        XCTAssertEqual(spadesKing.description, "♠️K")
    }

    func testDescriptionForHearts() {
        XCTAssertEqual(heartsAce.description, "♥️A")
        XCTAssertEqual(heartsTwo.description, "♥️2")
        XCTAssertEqual(heartsThree.description, "♥️3")
        XCTAssertEqual(heartsFour.description, "♥️4")
        XCTAssertEqual(heartsFive.description, "♥️5")
        XCTAssertEqual(heartsSix.description, "♥️6")
        XCTAssertEqual(heartsSeven.description, "♥️7")
        XCTAssertEqual(heartsEight.description, "♥️8")
        XCTAssertEqual(heartsNine.description, "♥️9")
        XCTAssertEqual(heartsTen.description, "♥️10")
        XCTAssertEqual(heartsJack.description, "♥️J")
        XCTAssertEqual(heartsQueen.description, "♥️Q")
        XCTAssertEqual(heartsKing.description, "♥️K")
    }

    func testDescriptionForDiamonds() {
        XCTAssertEqual(diamondsAce.description, "♦️A")
        XCTAssertEqual(diamondsTwo.description, "♦️2")
        XCTAssertEqual(diamondsThree.description, "♦️3")
        XCTAssertEqual(diamondsFour.description, "♦️4")
        XCTAssertEqual(diamondsFive.description, "♦️5")
        XCTAssertEqual(diamondsSix.description, "♦️6")
        XCTAssertEqual(diamondsSeven.description, "♦️7")
        XCTAssertEqual(diamondsEight.description, "♦️8")
        XCTAssertEqual(diamondsNine.description, "♦️9")
        XCTAssertEqual(diamondsTen.description, "♦️10")
        XCTAssertEqual(diamondsJack.description, "♦️J")
        XCTAssertEqual(diamondsQueen.description, "♦️Q")
        XCTAssertEqual(diamondsKing.description, "♦️K")
    }

    func testDescriptionForClubs() {
        XCTAssertEqual(clubsAce.description, "♣️A")
        XCTAssertEqual(clubsTwo.description, "♣️2")
        XCTAssertEqual(clubsThree.description, "♣️3")
        XCTAssertEqual(clubsFour.description, "♣️4")
        XCTAssertEqual(clubsFive.description, "♣️5")
        XCTAssertEqual(clubsSix.description, "♣️6")
        XCTAssertEqual(clubsSeven.description, "♣️7")
        XCTAssertEqual(clubsEight.description, "♣️8")
        XCTAssertEqual(clubsNine.description, "♣️9")
        XCTAssertEqual(clubsTen.description, "♣️10")
        XCTAssertEqual(clubsJack.description, "♣️J")
        XCTAssertEqual(clubsQueen.description, "♣️Q")
        XCTAssertEqual(clubsKing.description, "♣️K")
    }

    func testIsUpSide() {
        let diamondsAce: Card = Card.init(suit: .diamonds, rank: .ace)
        XCTAssertFalse(diamondsAce.isUpSide())
    }

    func testTurnUpSideDown() {
        let diamondsAce: Card = Card.init(suit: .diamonds, rank: .ace)
        XCTAssertFalse(diamondsAce.isUpSide())
        diamondsAce.turnUpSideDown()
        XCTAssertTrue(diamondsAce.isUpSide())
    }
}

// MARK: Image Test
extension CardTests {
    func testImageForSpades() {
        spadesAce.turnUpSideDown()
        spadesTwo.turnUpSideDown()
        spadesThree.turnUpSideDown()
        spadesFour.turnUpSideDown()
        spadesFive.turnUpSideDown()
        spadesSix.turnUpSideDown()
        spadesSeven.turnUpSideDown()
        spadesEight.turnUpSideDown()
        spadesNine.turnUpSideDown()
        spadesTen.turnUpSideDown()
        spadesJack.turnUpSideDown()
        spadesQueen.turnUpSideDown()
        spadesKing.turnUpSideDown()
        XCTAssertEqual(spadesAce.image, "sA")
        XCTAssertEqual(spadesTwo.image, "s2")
        XCTAssertEqual(spadesThree.image, "s3")
        XCTAssertEqual(spadesFour.image, "s4")
        XCTAssertEqual(spadesFive.image, "s5")
        XCTAssertEqual(spadesSix.image, "s6")
        XCTAssertEqual(spadesSeven.image, "s7")
        XCTAssertEqual(spadesEight.image, "s8")
        XCTAssertEqual(spadesNine.image, "s9")
        XCTAssertEqual(spadesTen.image, "s10")
        XCTAssertEqual(spadesJack.image, "sJ")
        XCTAssertEqual(spadesQueen.image, "sQ")
        XCTAssertEqual(spadesKing.image, "sK")
    }

    func testImageForHearts() {
        heartsAce.turnUpSideDown()
        heartsTwo.turnUpSideDown()
        heartsThree.turnUpSideDown()
        heartsFour.turnUpSideDown()
        heartsFive.turnUpSideDown()
        heartsSix.turnUpSideDown()
        heartsSeven.turnUpSideDown()
        heartsEight.turnUpSideDown()
        heartsNine.turnUpSideDown()
        heartsTen.turnUpSideDown()
        heartsJack.turnUpSideDown()
        heartsQueen.turnUpSideDown()
        heartsKing.turnUpSideDown()
        XCTAssertEqual(heartsAce.image, "hA")
        XCTAssertEqual(heartsTwo.image, "h2")
        XCTAssertEqual(heartsThree.image, "h3")
        XCTAssertEqual(heartsFour.image, "h4")
        XCTAssertEqual(heartsFive.image, "h5")
        XCTAssertEqual(heartsSix.image, "h6")
        XCTAssertEqual(heartsSeven.image, "h7")
        XCTAssertEqual(heartsEight.image, "h8")
        XCTAssertEqual(heartsNine.image, "h9")
        XCTAssertEqual(heartsTen.image, "h10")
        XCTAssertEqual(heartsJack.image, "hJ")
        XCTAssertEqual(heartsQueen.image, "hQ")
        XCTAssertEqual(heartsKing.image, "hK")
    }

    func testImageForDiamonds() {
        diamondsAce.turnUpSideDown()
        diamondsTwo.turnUpSideDown()
        diamondsThree.turnUpSideDown()
        diamondsFour.turnUpSideDown()
        diamondsFive.turnUpSideDown()
        diamondsSix.turnUpSideDown()
        diamondsSeven.turnUpSideDown()
        diamondsEight.turnUpSideDown()
        diamondsNine.turnUpSideDown()
        diamondsTen.turnUpSideDown()
        diamondsJack.turnUpSideDown()
        diamondsQueen.turnUpSideDown()
        diamondsKing.turnUpSideDown()
        XCTAssertEqual(diamondsAce.image, "dA")
        XCTAssertEqual(diamondsTwo.image, "d2")
        XCTAssertEqual(diamondsThree.image, "d3")
        XCTAssertEqual(diamondsFour.image, "d4")
        XCTAssertEqual(diamondsFive.image, "d5")
        XCTAssertEqual(diamondsSix.image, "d6")
        XCTAssertEqual(diamondsSeven.image, "d7")
        XCTAssertEqual(diamondsEight.image, "d8")
        XCTAssertEqual(diamondsNine.image, "d9")
        XCTAssertEqual(diamondsTen.image, "d10")
        XCTAssertEqual(diamondsJack.image, "dJ")
        XCTAssertEqual(diamondsQueen.image, "dQ")
        XCTAssertEqual(diamondsKing.image, "dK")
    }

    func testImageForClubs() {
        clubsAce.turnUpSideDown()
        clubsTwo.turnUpSideDown()
        clubsThree.turnUpSideDown()
        clubsFour.turnUpSideDown()
        clubsFive.turnUpSideDown()
        clubsSix.turnUpSideDown()
        clubsSeven.turnUpSideDown()
        clubsEight.turnUpSideDown()
        clubsNine.turnUpSideDown()
        clubsTen.turnUpSideDown()
        clubsJack.turnUpSideDown()
        clubsQueen.turnUpSideDown()
        clubsKing.turnUpSideDown()
        XCTAssertEqual(clubsAce.image, "cA")
        XCTAssertEqual(clubsTwo.image, "c2")
        XCTAssertEqual(clubsThree.image, "c3")
        XCTAssertEqual(clubsFour.image, "c4")
        XCTAssertEqual(clubsFive.image, "c5")
        XCTAssertEqual(clubsSix.image, "c6")
        XCTAssertEqual(clubsSeven.image, "c7")
        XCTAssertEqual(clubsEight.image, "c8")
        XCTAssertEqual(clubsNine.image, "c9")
        XCTAssertEqual(clubsTen.image, "c10")
        XCTAssertEqual(clubsJack.image, "cJ")
        XCTAssertEqual(clubsQueen.image, "cQ")
        XCTAssertEqual(clubsKing.image, "cK")
    }
}

// MARK: For CardGame
extension CardTests {
    func testIsKing() {
        XCTAssertFalse(clubsAce.isKing())
        XCTAssertFalse(clubsTwo.isKing())
        XCTAssertFalse(clubsThree.isKing())
        XCTAssertFalse(clubsFour.isKing())
        XCTAssertFalse(clubsFive.isKing())
        XCTAssertFalse(clubsSix.isKing())
        XCTAssertFalse(clubsSeven.isKing())
        XCTAssertFalse(clubsEight.isKing())
        XCTAssertFalse(clubsNine.isKing())
        XCTAssertFalse(clubsTen.isKing())
        XCTAssertFalse(clubsJack.isKing())
        XCTAssertFalse(clubsQueen.isKing())
        XCTAssertTrue(clubsKing.isKing())
        XCTAssertTrue(spadesKing.isKing())
        XCTAssertTrue(diamondsKing.isKing())
        XCTAssertTrue(heartsKing.isKing())
    }

    func testIsAce() {
        XCTAssertTrue(clubsAce.isAce())
        XCTAssertFalse(clubsTwo.isAce())
        XCTAssertFalse(clubsThree.isAce())
        XCTAssertFalse(clubsFour.isAce())
        XCTAssertFalse(clubsFive.isAce())
        XCTAssertFalse(clubsSix.isAce())
        XCTAssertFalse(clubsSeven.isAce())
        XCTAssertFalse(clubsEight.isAce())
        XCTAssertFalse(clubsNine.isAce())
        XCTAssertFalse(clubsTen.isAce())
        XCTAssertFalse(clubsJack.isAce())
        XCTAssertFalse(clubsQueen.isAce())
        XCTAssertFalse(clubsKing.isAce())
        XCTAssertTrue(spadesAce.isAce())
        XCTAssertTrue(diamondsAce.isAce())
        XCTAssertTrue(heartsAce.isAce())
    }

    func testIsOneRankDown() {
        XCTAssertTrue(clubsAce.isOneRankDown(from: clubsTwo))
        XCTAssertTrue(clubsAce.isOneRankDown(from: spadesTwo))
        XCTAssertTrue(clubsAce.isOneRankDown(from: heartsTwo))
        XCTAssertTrue(clubsAce.isOneRankDown(from: diamondsTwo))
        XCTAssertFalse(clubsThree.isOneRankDown(from: clubsTwo))
        XCTAssertFalse(clubsSeven.isOneRankDown(from: spadesTwo))
        XCTAssertFalse(clubsTen.isOneRankDown(from: heartsTwo))
        XCTAssertFalse(clubsKing.isOneRankDown(from: diamondsTwo))
    }

    func testIsDifferentColor() {
        XCTAssertFalse(clubsAce.isDifferentColor(with: clubsTwo))
        XCTAssertFalse(clubsAce.isDifferentColor(with: spadesTwo))
        XCTAssertTrue(clubsAce.isDifferentColor(with: heartsTwo))
        XCTAssertTrue(clubsAce.isDifferentColor(with: diamondsTwo))
        XCTAssertFalse(clubsThree.isDifferentColor(with: clubsTwo))
        XCTAssertFalse(clubsSeven.isDifferentColor(with: spadesTwo))
        XCTAssertTrue(clubsTen.isDifferentColor(with: heartsTwo))
        XCTAssertTrue(clubsKing.isDifferentColor(with: diamondsTwo))
    }

    func testIsOneRankUp() {
        XCTAssertFalse(clubsAce.isOneRankUp(from: clubsTwo))
        XCTAssertFalse(clubsAce.isOneRankUp(from: spadesTwo))
        XCTAssertFalse(clubsAce.isOneRankUp(from: heartsTwo))
        XCTAssertFalse(clubsAce.isOneRankUp(from: diamondsTwo))
        XCTAssertTrue(clubsThree.isOneRankUp(from: clubsTwo))
        XCTAssertTrue(clubsSeven.isOneRankUp(from: spadesSix))
        XCTAssertTrue(clubsTen.isOneRankUp(from: heartsNine))
        XCTAssertTrue(clubsKing.isOneRankUp(from: diamondsQueen))
    }

    func testIsSameSuit() {
        XCTAssertTrue(clubsAce.isSameSuit(with: clubsTwo))
        XCTAssertFalse(clubsAce.isSameSuit(with: spadesTwo))
        XCTAssertFalse(clubsAce.isSameSuit(with: heartsTwo))
        XCTAssertFalse(clubsAce.isSameSuit(with: diamondsTwo))
        XCTAssertTrue(clubsThree.isSameSuit(with: clubsTwo))
        XCTAssertFalse(clubsSeven.isSameSuit(with: spadesTwo))
        XCTAssertFalse(clubsTen.isSameSuit(with: heartsTwo))
        XCTAssertFalse(clubsKing.isSameSuit(with: diamondsTwo))
    }

}
