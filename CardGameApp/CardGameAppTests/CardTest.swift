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

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDescriptionForSpades() {
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

}
