//
//  Pocker.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 1. 31..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

// 포커게임의 스코어 계산 기능 제공.
protocol PokerScoreable {
    func getBestHand() -> PokerHands.HandRanks

    func sortCards() -> [Card]

    func getTopCard() -> Card
}
