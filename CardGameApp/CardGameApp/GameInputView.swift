//
//  GameInputView.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 7..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct GameInputView {
    static func readGameType() -> GameType? {
        let input = InputView.readInput(ment: "카드 게임 종류를 선택하세요.\n1. 7카드\n2. 5카드\n> ")
        switch input {
        case "1":
            return .one
        case "2":
            return .two
        default:
            return nil
        }
    }
    
    static func readNumberOfParticipant() -> NumberOfParticipant? {
        let input = InputView.readInput(ment: "참여할 사람의 인원을 입력하세요.\n> ")
        guard let intInput = Int(input) else {return nil}
        for number in NumberOfParticipant.allCases {
            if intInput == number.rawValue {return number}
        }
        return nil
    }
}
