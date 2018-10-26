//
//  InputProperty.swift
//  CardGame
//
//  Created by oingbong on 2018. 8. 30..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum GameType: String {
    case seven = "1"
    case five = "2"
    
    var number: Int {
        switch self {
        case .seven:
            return 7
        case .five:
            return 5
        }
    }
}

enum NumberOfPlayers: Int {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
}

enum Message: CustomStringConvertible {
    case gameType
    case readPlayer
    
    var description: String {
        switch self {
        case .gameType:
            return "카드 게임 종류를 선택하세요. \n1. 7카드 \n2. 5카드"
        case .readPlayer:
            return "참여할 사람의 인원을 입력하세요."
        }
    }
}
