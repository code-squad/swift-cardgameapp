//
//  CardClassTest.swift
//  CardGameAppTests
//
//  Created by yangpc on 2017. 12. 22..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import XCTest
@testable import CardGameApp

class CardClassTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_card_description_spadeAce() {
        let spadeAce = Card(suit: .spade, rank: .ace)
        XCTAssertEqual(spadeAce.description, "♠️A")
    }

    func test_card_description_heartJack() {
        let heartJack = Card(suit: .heart, rank: .jack)
        XCTAssertEqual(heartJack.description, "♥️J")
    }

    func test_card_description_diamondQueen() {
        let diamondQueen = Card(suit: .diamond, rank: .queen)
        XCTAssertEqual(diamondQueen.description, "♦️Q")
    }

    func test_card_description_clubTen() {
        let clubTen = Card(suit: .club, rank: .ten)
        XCTAssertEqual(clubTen.description, "♣️10")
    }

}
