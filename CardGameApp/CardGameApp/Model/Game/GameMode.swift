//
//  GameMode.swift
//  CardGame
//
//  Created by 윤지영 on 16/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum GameMode: Int, CaseIterable {
    case fiveStud = 1, sevenStud

    var numberOfCards: Int {
        switch self {
        case .fiveStud:
            return 5
        case .sevenStud:
            return 7
        }
    }
}
