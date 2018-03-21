//
//  GameInfo.swift
//  CardGame
//
//  Created by jack on 2018. 1. 11..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GameInfo {
    
    var userCards : Int = 7, userPlayers : Int
    
    init(_ inputGameMenu : Int , _ inputPlayers : Int) {
        if inputGameMenu == 2 {
            self.userCards = 5
        }
        self.userPlayers = inputPlayers
    }
    
}

