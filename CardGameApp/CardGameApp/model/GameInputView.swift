//
//  GameInputView.swift
//  CardGame
//
//  Created by Yoda Codd on 2018. 6. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum GameMode : Int {
    case sevenCard = 7
    case fiveCard = 5
}

struct GameInputView {
    /// 게임 선택 메세지
    func printGameMode(){
        print ("""
카드 게임 종류를 선택하세요.
1. 7카드
2. 5카드
""")
    }
    
    /// 참여인원을 묻는 함수
    func printHowManyPlayer(){
        print("참여할 사람의 인원을 입력하세요.")
    }
    
    /// 유저입력을 받아서 리턴하는 함수
    private func requestUserInput() -> String {
        return readLine()!
    }
    
    /// 게임모드를 고르는 함수
    func selectGameMode() -> GameMode {
        while true {
            printGameMode()
            let userInput = requestUserInput()
            switch userInput {
            case "1" : return GameMode.sevenCard
            case "2" : return .fiveCard
            default : continue
            }
        }
    }
    
    /// 참여인원을 리턴한다
    func selectPlayerNumber() -> Int {
        while true {
            printHowManyPlayer()
            let userInput = requestUserInput()
            switch userInput {
            case "1" : return 1
            case "2" : return 2
            case "3" : return 3
            case "4" : return 4
            default : continue
            }
        }
    }
}
