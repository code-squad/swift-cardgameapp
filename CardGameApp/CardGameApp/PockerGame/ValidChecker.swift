//
//  ValidChecker.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 7..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct ValidChecker {
    static func check(numberOfParticipant:NumberOfParticipant) -> Bool {
        let oneToFour = 1...4
        return oneToFour.contains(numberOfParticipant.rawValue)
    }
    
    static func check(gameType:GameType) -> Bool {
        return gameType.rawValue == 5 || gameType.rawValue == 7
    }
    
    static func checkContinuable(gameType:GameType, numberOfParticipant:NumberOfParticipant, numberOfCards:Int) -> Bool {
        return numberOfCards >= (numberOfParticipant.rawValue + 1) * gameType.rawValue
    }
}
