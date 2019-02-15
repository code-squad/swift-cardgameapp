//
//  Shape.swift
//  CardGame
//
//  Created by 윤동민 on 04/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum CardShape : CustomStringConvertible, CaseIterable {
    case spade
    case clover
    case diamond
    case heart
    var description: String {
        switch self {
        case .spade:
            return "♠️"
        case .clover:
            return "♣️"
        case .heart:
            return "♥️"
        case .diamond:
            return "♦️"
        }
    }
}
