//
//  CardGamePlayer.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 1. 31..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

// 카드게임 플레이어를 위한 기능 제공.
protocol CardGamePlayer {
    func take(a newCard: Card?)

    func take(cards: CardStack)

    func showAllCards() -> CardStack

    func showACard() -> Card?

    func returnCards()
}
