//
//  CardGameInfo.swift
//  CardGame
//
//  Created by Mrlee on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// 카드게임의 정보를 담는 데이터 구조체. 게임의 정보는 크게 두가지로 나뉨.
// 1. 게임의 종류(5포커, 7포커).
// 2. 플레이어의 수.

struct CardGameInfo {
    enum Games: Int {
        case sevenPoker = 7
        case fivePoker = 5
    }
    
    private (set) var typeOfGames: Games
    private (set) var players: Int
    
    // 최조로 CardGameInfo를 인스턴스화 할때 가장 기본적인 프로퍼티들을 생성하는 생성자.
    init(typeOf: Games, withPlayers: Int) {
        self.typeOfGames = typeOf
        self.players = withPlayers
    }
}
