//
//  CardStackPrint.swift
//  CardGame
//
//  Created by Mrlee on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// 카드게임시 가상의 테이블을 만드는 클래스.
// 게임을 진행하려면 테이블이 필요한데 테이블은 플레이어들의 스택(카드뭉치)를 가지고있다.

class Table {
    private (set) var cardStacksOfTable: [[Card]]
    private (set) var gameInfo: CardGameInfo
    private var deck: Deck
    
    // 게임의 타입과 플레이어의 숫자에 따라, 각자 가지고있는 카드의 수, 플레이어의 수에 맞추어
    // 테이블을 세팅한다.
    init(gameInfo: CardGameInfo, with deck: Deck) {
        self.cardStacksOfTable = [[Card]]()
        self.gameInfo = gameInfo
        self.deck = deck
        self.deck.shuffle()
    }

    // gameInfo를 가지고 실제 테이블 세팅을 수행.
    // 테이블 세팅은 하나의 deck을 공용으로 사용한다. 플레이어들에게 분배된 카드를 제외한 나머지 카드를 되돌려줌.
    func dealTheCardOfGameTable() throws -> Deck {
        for _ in 0..<gameInfo.players {
            guard let playerStack = try? self.deck.makeStack(numberOfCards: gameInfo.typeOfGames.rawValue) else {
                throw ErrorCode.zeroCard
            }
            cardStacksOfTable.append(playerStack)
        }
        return self.deck
    }
    
}
