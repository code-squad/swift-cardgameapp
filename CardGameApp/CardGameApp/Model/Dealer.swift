//
//  Dealer.swift
//  CardGame
//
//  Created by 심 승민 on 2017. 11. 28..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct Dealer {
    // 딜러가 운용하는 덱.
    private var deck: Deck
    init(with deck: Deck) {
        self.deck = deck
    }

    // 딜러가 게임 시작.
    mutating func introduce(_ players: [Player], _ stud: StudPokerGame.Stud) throws {
        // 덱의 카드 섞기.
        self.deck.shuffle()
        // 모든 플레이어에게 카드 분배.
        try self.dealCards(numberOf: stud.rawValue, to: players)
    }

    // 모든 플레이어에게 stud 개수의 카드 분배.
    private mutating func dealCards(numberOf count: StudPokerGame.Stud.RawValue, to players: [Player]) throws {
        // 이전게임 시 플레이어들의 스택 지우기. (이전 게임에 사용된 카드는 제외)
        self.takeBackAllCards(from: players)
        // 각 플레이어에게 카드 분배. (딜러 자신도 포함.)
        for player in 0..<players.count {
            // 덱에서 카드 여러장(stud) 뽑음.
            let cardStackForOnePlayer = try drawCards(numberOf: count)
            // 뽑은 카드를 플레이어가 가짐.
            players[player].take(cards: cardStackForOnePlayer)
        }
    }

    // 덱에서 카드를 stud 개수만큼 뽑음.
    private func drawCards(numberOf count: StudPokerGame.Stud.RawValue) throws -> CardStack {
        guard let newCardStack = self.deck.drawMany(selectedCount: count) else { throw StudPokerGame.Error.lackOfCards }
        return newCardStack
    }

    // 모든 플레이어의 카드 회수.
    private mutating func takeBackAllCards(from players: [Player]) {
        for player in players {
            self.takeBackCards(from: player)
        }
    }

    // 플레이어의 카드 회수.
    private mutating func takeBackCards(from player: Player) {
        player.returnCards()
    }

}
