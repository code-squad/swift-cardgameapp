//
//  CardGameAppTests.swift
//  CardGameAppTests
//
//  Created by TaeHyeonLee on 2018. 1. 26..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import XCTest
@testable import CardGameApp

class DealerActionTest: XCTestCase {
    var baseDealerAction: DealerAction!

    override func setUp() {
        super.setUp()
        baseDealerAction = DealerAction()
    }

    override func tearDown() {
        baseDealerAction = nil
        super.tearDown()
    }

    func testIsRemain() {
        let dealerAction = DealerAction()
        XCTAssert(dealerAction.isRemain())
    }

    func testCount() {
        let dealerAction = DealerAction()
        XCTAssertEqual(dealerAction.count(), 52)
    }

    func testShuffle() {
        var dealerAction = DealerAction()
        XCTAssertEqual(dealerAction, baseDealerAction)
        dealerAction.shuffle()
        XCTAssertNotEqual(dealerAction, baseDealerAction)
    }

    func testReset() {
        var dealerAction = DealerAction()
        XCTAssertEqual(dealerAction, baseDealerAction)
        dealerAction.shuffle()
        XCTAssertNotEqual(dealerAction, baseDealerAction)
        dealerAction.reset()
        XCTAssertEqual(dealerAction, baseDealerAction)
    }

    func testRemoveOne() {
        var dealerAction = DealerAction()
        let card = dealerAction.removeOne()
        XCTAssertEqual(card?.description, "♣️K")
    }

    func testGetCardPacks() {
        var dealerAction = DealerAction()
        let cardPacks = dealerAction.getCardPacks(packCount: 3)
        XCTAssertEqual(cardPacks.description, "[[♣️K], [♦️K, ♥️K], [♠️K, ♣️Q, ♦️Q]]")
    }

    func testOpen() {
        var dealerAction = DealerAction()
        XCTAssertEqual(dealerAction.open()?.description, "♣️K")
    }

}
