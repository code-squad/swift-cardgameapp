//
//  WinnerInfo.swift
//  CardGame
//
//  Created by jack on 2018. 1. 13..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct WinnerInfo {
    var handOfWinner : Hand.HandName
    var numberOfWinner : Int = 0
    
    init(_ hand : Hand.HandName, _ number : Int) {
        self.handOfWinner = hand
        self.numberOfWinner = number
    }
    
    func isDealer(_ gameInfo : GameInfo) -> Bool {
        return self.numberOfWinner == gameInfo.userPlayers
    }
}

