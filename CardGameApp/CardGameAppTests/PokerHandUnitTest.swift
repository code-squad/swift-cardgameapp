//
//  PokerHandUnitTest.swift
//  CardGameUnitTest
//
//  Created by Mrlee on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest
@testable import CardGameApp

class PokerHandUnitTest: XCTestCase {
    // [clubs, hearts, diamonds, spades]
    func testHighCard() {
        let diamond_J = Card(suit: 2, rank: 10)
        let club_Q = Card(suit: 0, rank: 11)
        let club_7 = Card(suit: 0, rank: 6)
        let heart_five = Card(suit: 1, rank: 4)
        let spade_Eight = Card(suit: 3, rank: 7)
        let testStack = [diamond_J, club_Q, club_7, heart_five, spade_Eight]
        let calculate = PokerHand()
        XCTAssertEqual(calculate.makePokerHandRanking([testStack]).score[0], 13)
    }
    
    func testOnePairWhenSameOnePairHand() {
        let diamond_J = Card(suit: 2, rank: 10)
        let club_J = Card(suit: 0, rank: 10)
        let spade_J = Card(suit: 3, rank: 10)
        let heart_J = Card(suit: 1, rank: 10)
        let testStack1 = [diamond_J, club_J]
        let testStack2 = [spade_J, heart_J] // spade OnePair is greater than another OnePair.
        let calculate = PokerHand()
        XCTAssertGreaterThan(calculate.makePokerHandRanking([testStack2]).score[0], calculate.makePokerHandRanking([testStack1]).score[0])
    }
    
    func testTwoPair() {
        let diamond_J = Card(suit: 2, rank: 10)
        let club_J = Card(suit: 0, rank: 10)
        let spade_A = Card(suit: 3, rank: 0)
        let heart_A = Card(suit: 1, rank: 0)
        let testStack = [diamond_J, club_J, spade_A, heart_A]
        let calculate = PokerHand()
        XCTAssertEqual(calculate.makePokerHandRanking([testStack]).hand[0], PokerHand.PokerRank.twoPair)
    }
    
    func testThreeOfKind() {
        let diamond_J = Card(suit: 2, rank: 10)
        let club_J = Card(suit: 0, rank: 10)
        let spade_J = Card(suit: 3, rank: 10)
        let heart_A = Card(suit: 1, rank: 0)
        let testStack = [diamond_J, club_J, spade_J, heart_A]
        let calculate = PokerHand()
        XCTAssertEqual(calculate.makePokerHandRanking([testStack]).hand[0], PokerHand.PokerRank.threeOfKind)
    }
    
    func testStraigth() {
        let diamond_A = Card(suit: 2, rank: 0)
        let club_2 = Card(suit: 0, rank: 1)
        let spade_3 = Card(suit: 3, rank: 2)
        let heart_4 = Card(suit: 1, rank: 3)
        let club_5 = Card(suit: 0, rank: 4)
        let testStack = [diamond_A, club_2, spade_3, heart_4, club_5]
        let calculate = PokerHand()
        XCTAssertEqual(calculate.makePokerHandRanking([testStack]).hand[0], PokerHand.PokerRank.straight)
    }
    
    func testStraigthOneCountinuousValueIsMissing() {
        let diamond_A = Card(suit: 2, rank: 0)
        let club_2 = Card(suit: 0, rank: 1)
        let spade_3 = Card(suit: 3, rank: 2)
        let heart_4 = Card(suit: 1, rank: 3)
        let club_6 = Card(suit: 0, rank: 5)
        let heart_7 = Card(suit: 1, rank: 6)
        let testStack = [diamond_A, club_2, spade_3, heart_4, club_6, heart_7]
        let calculate = PokerHand()
        XCTAssertNotEqual(calculate.makePokerHandRanking([testStack]).hand[0], PokerHand.PokerRank.straight)
    }
    
    func testRoyalStraigth() {
        let diamond_A = Card(suit: 2, rank: 0)
        let club_10 = Card(suit: 0, rank: 9)
        let spade_J = Card(suit: 3, rank: 10)
        let heart_Q = Card(suit: 1, rank: 11)
        let club_K = Card(suit: 0, rank: 12)
        let testStack = [diamond_A, club_10, spade_J, heart_Q, club_K]
        let calculate = PokerHand()
        XCTAssertEqual(calculate.makePokerHandRanking([testStack]).hand[0], PokerHand.PokerRank.royalStraight)
    }
    
    func testFlush() {
        let diamond_A = Card(suit: 2, rank: 0)
        let diamond_2 = Card(suit: 2, rank: 1)
        let diamond_4 = Card(suit: 2, rank: 3)
        let diamond_6 = Card(suit: 2, rank: 5)
        let diamond_8 = Card(suit: 2, rank: 7)
        let testStack = [diamond_A, diamond_2, diamond_4, diamond_6, diamond_8]
        let calculate = PokerHand()
        XCTAssertEqual(calculate.makePokerHandRanking([testStack]).hand[0], PokerHand.PokerRank.flush)
    }
    
    func testFullHouse() {
        let diamond_J = Card(suit: 2, rank: 10)
        let club_J = Card(suit: 0, rank: 10)
        let spade_J = Card(suit: 3, rank: 10)
        let heart_A = Card(suit: 1, rank: 0)
        let club_A = Card(suit: 0, rank: 0)
        let testStack = [diamond_J, club_J, spade_J, heart_A, club_A]
        let calculate = PokerHand()
        XCTAssertEqual(calculate.makePokerHandRanking([testStack]).hand[0], PokerHand.PokerRank.fullhouse)
    }
    
    func testFourOfKind() {
        let diamond_J = Card(suit: 2, rank: 10)
        let club_J = Card(suit: 0, rank: 10)
        let spade_J = Card(suit: 3, rank: 10)
        let heart_J = Card(suit: 1, rank: 10)
        let testStack = [diamond_J, club_J, spade_J, heart_J]
        let calculate = PokerHand()
        XCTAssertEqual(calculate.makePokerHandRanking([testStack]).hand[0], PokerHand.PokerRank.fourOfKind)
    }
    
    func testStraigthFlush() {
        let diamond_A = Card(suit: 2, rank: 0)
        let diamond_2 = Card(suit: 2, rank: 1)
        let diamond_3 = Card(suit: 2, rank: 2)
        let diamond_4 = Card(suit: 2, rank: 3)
        let diamond_5 = Card(suit: 2, rank: 4)
        let testStack = [diamond_A, diamond_2, diamond_3, diamond_4, diamond_5]
        let calculate = PokerHand()
        XCTAssertEqual(calculate.makePokerHandRanking([testStack]).hand[0], PokerHand.PokerRank.straightFlush)
    }
    
    func testRoyalStraigthFlush() {
        let diamond_A = Card(suit: 2, rank: 0)
        let diamond_10 = Card(suit: 2, rank: 9)
        let diamond_J = Card(suit: 2, rank: 10)
        let diamond_Q = Card(suit: 2, rank: 11)
        let diamond_K = Card(suit: 2, rank: 12)
        let testStack = [diamond_A, diamond_10, diamond_J, diamond_Q, diamond_K]
        let calculate = PokerHand()
        XCTAssertEqual(calculate.makePokerHandRanking([testStack]).hand[0], PokerHand.PokerRank.royalStraightFlush)
    }
    
}
