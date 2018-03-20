//
//  FoundataionsViewModelTest.swift
//  CardGameAppTests
//
//  Created by TaeHyeonLee on 2018. 3. 15..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import XCTest

class FoundataionsViewModelTest: XCTestCase {
    var foundationsVM: FoundationsViewModel!

    override func setUp() {
        super.setUp()
        foundationsVM = FoundationsViewModel.sharedInstance()
    }

    override func tearDown() {
        foundationsVM = nil
        super.tearDown()
    }

    func testReset() {
        foundationsVM.reset()
    }

    func testAvailablePosition() {
        let spadesAce: Card = Card(suit: .spades, rank: .ace)
        let spadesTwo: Card = Card(suit: .spades, rank: .two)
        XCTAssertNotNil(foundationsVM.availablePosition(of: spadesAce))
        XCTAssertNil(foundationsVM.availablePosition(of: spadesTwo))
    }

    func testAvailablePositionsForDragging() {
        let spadesAce: Card = Card(suit: .spades, rank: .ace)
        let spadesTwo: Card = Card(suit: .spades, rank: .two)
        XCTAssertEqual(foundationsVM.availablePositionsForDragging(of: spadesAce).count, 4)
        XCTAssertEqual(foundationsVM.availablePositionsForDragging(of: spadesTwo).count, 0)
    }

    func testPush() {
        let spadesAce: Card = Card(suit: .spades, rank: .ace)
        let cardIndexes: CardIndexes = (xIndex: 0, yIndex: 0)
        XCTAssertTrue(foundationsVM.push(cards: [spadesAce], indexes: cardIndexes))
    }

}
