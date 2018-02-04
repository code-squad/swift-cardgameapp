//
//  Player.swift
//  CardGame
//
//  Created by 심 승민 on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

class Player: CardGamePlayer {
    let name: String
    private var cardStack: CardStack
    init(_ playerId: Int?) {
        // 플레이어 이름 생성. id가 없는 경우, dealer 생성.
        if let playerId = playerId {
            self.name = "Player\(playerId+1)"
        } else {
            self.name = "Dealer"
        }
        self.cardStack = CardStack()
    }

    // 카드 한 장 받기.
    func take(a newCard: Card?) {
        guard let card = newCard else { return }
        self.cardStack.push(card: card)
    }

    // 카드 여러 장 받기.
    func take(cards: CardStack) {
        for card in cards {
            self.take(a: card)
        }
    }

    // 탑카드 한 장 보여줌.
    func showACard() -> Card? {
        return self.cardStack.peek()
    }

    // 모든 카드 보여줌.
    func showAllCards() -> CardStack {
        return self.cardStack
    }

    // 모든 카드 딜러에게 반환.
    func returnCards() {
        self.cardStack.reset()
    }

    // 플레이어가 가진 패 중 가장 높은 패의 랭크.
    var stackRank: PokerHands.HandRanks {
        return self.cardStack.getBestHand()
    }

    // 플레이어가 가진 탑카드.
    var topCard: Card {
        return self.cardStack.getTopCard()
    }

}
