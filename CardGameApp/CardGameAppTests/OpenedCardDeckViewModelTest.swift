//
//  OpenedCardDeckViewModelTest.swift
//  CardGameAppTests
//
//  Created by TaeHyeonLee on 2018. 3. 15..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import XCTest

class OpenedCardDeckViewModelTest: XCTestCase {
    var openedCardDeckVM: OpenedCardDeckViewModel!
    let spadesAce = Card(suit: .spades, rank: .ace)
    let spadesTwo = Card(suit: .spades, rank: .two)

    override func setUp() {
        super.setUp()
        openedCardDeckVM = OpenedCardDeckViewModel.sharedInstance()
    }

    override func tearDown() {
        openedCardDeckVM = nil
        super.tearDown()
    }

    func testPush() {
        XCTAssertTrue(openedCardDeckVM.push(card: spadesTwo))
        openedCardDeckVM.reset()
    }

    func testReLoad() {
        XCTAssertTrue(openedCardDeckVM.push(card: spadesTwo))
        XCTAssertEqual(openedCardDeckVM.reLoad(), [spadesTwo])
        openedCardDeckVM.reset()
    }

    func testReset() {
        openedCardDeckVM.reset()
    }

    func testGetSelectedCardInformation() {
        XCTAssertTrue(openedCardDeckVM.push(card: spadesAce))
        XCTAssertNotNil(openedCardDeckVM.getSelectedCardInformation(image: "sA"))
        openedCardDeckVM.reset()
    }

    func testPop() {
        XCTAssertTrue(openedCardDeckVM.push(card: spadesAce))
        XCTAssertEqual(openedCardDeckVM.pop(indexes: (xIndex: 0, yIndex: 0)), [spadesAce])
        openedCardDeckVM.reset()
    }
}
