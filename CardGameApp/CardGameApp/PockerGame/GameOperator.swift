//
//  GameOperator.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 10..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol GameOperator {
    mutating func distributeCard(gameType:Int, numberOfParticipant:Int) -> [GamePlayer]
    func numberOfDeck() -> Int
}
