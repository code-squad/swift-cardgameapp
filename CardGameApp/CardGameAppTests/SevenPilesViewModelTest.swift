//
//  SevenPilesViewModelTest.swift
//  CardGameAppTests
//
//  Created by TaeHyeonLee on 2018. 3. 19..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import XCTest

class SevenPilesViewModelTest: XCTestCase {
    var sevenPilesVM: SevenPilesViewModel!
    var dealerAction = DealerAction()
    let spadesAce = Card(suit: .spades, rank: .ace)
    let spadesTwo = Card(suit: .spades, rank: .two)
    let clubsKing: Card = Card.init(suit: .clubs, rank: .king)

    override func setUp() {
        super.setUp()
        sevenPilesVM = SevenPilesViewModel.sharedInstance()
        sevenPilesVM.spreadCardPiles(sevenPiles: dealerAction.getCardPacks(packCount: 7))
    }

    override func tearDown() {
        sevenPilesVM = nil
        super.tearDown()
    }

//    func testSpreadCardPiles() {
//        sevenPilesVM.spreadCardPiles(sevenPiles: dealerAction.getCardPacks(packCount: 7))
//    }

//    func testReset() {
//        sevenPilesVM.reset()
//    }

    func testGetSelectedCardInformation() {
        XCTAssertNil(sevenPilesVM.getSelectedCardInformation(image: "sA"))
        XCTAssertNotNil(sevenPilesVM.getSelectedCardInformation(image: "h10"))
        XCTAssertNotNil(sevenPilesVM.getSelectedCardInformation(image: "hK"))
        XCTAssertNotNil(sevenPilesVM.getSelectedCardInformation(image: "c8"))
        XCTAssertNotNil(sevenPilesVM.getSelectedCardInformation(image: "cK"))
        XCTAssertNotNil(sevenPilesVM.getSelectedCardInformation(image: "s7"))
        XCTAssertNotNil(sevenPilesVM.getSelectedCardInformation(image: "dJ"))
        XCTAssertNotNil(sevenPilesVM.getSelectedCardInformation(image: "dQ"))
        sevenPilesVM.reset()
    }

    func testPop() {
        XCTAssertEqual(sevenPilesVM.pop(indexes: (xIndex: 0, yIndex: 0)), [clubsKing])
        sevenPilesVM.reset()
    }

    func testAvailablePosition() {
        let diamondsQueen: Card = Card.init(suit: .diamonds, rank: .queen)
        XCTAssertNil(sevenPilesVM.availablePosition(of: clubsKing))
        XCTAssertNotNil(sevenPilesVM.availablePosition(of: diamondsQueen))
        sevenPilesVM.reset()
    }

    func testAvailablePositionsForDragging() {
        let clubsEight = Card.init(suit: .clubs, rank: .eight)
        XCTAssertEqual(sevenPilesVM.availablePositionsForDragging(of: clubsEight).count, 0)
        let heartsQueen: Card = Card.init(suit: .hearts, rank: .queen)
        XCTAssertEqual(sevenPilesVM.availablePositionsForDragging(of: heartsQueen).count, 1)
        sevenPilesVM.reset()
    }

    func testPush() {
        let heartsQueen: Card = Card.init(suit: .hearts, rank: .queen)
        XCTAssertTrue(sevenPilesVM.push(cards: [heartsQueen], indexes: (xIndex: 0, yIndex: 1)))
        sevenPilesVM.reset()
    }

}
