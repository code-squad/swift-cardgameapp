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
    private var deck: CardGameInfo
    
    // 테이블을 세팅한다.
    init(with deck: CardGameInfo) {
        self.cardStacksOfTable = [[Card]]()
        self.deck = deck
        self.deck.shuffle()
    }

    // gameInfo를 가지고 실제 테이블 세팅을 수행.
    // 테이블 세팅은 하나의 deck을 공용으로 사용한다. 플레이어들에게 분배된 카드를 제외한 나머지 카드를 되돌려줌.
    func dealTheCardOfGameTable() throws -> CardGameInfo {
        for index in 1...7 {
            guard let playerStack = try? self.deck.makeStack(numberOfCards: index) else {
                throw ErrorCode.zeroCard
            }
            playerStack.last?.flipCard()
            cardStacksOfTable.append(playerStack)
        }
        return self.deck
    }
    
}
